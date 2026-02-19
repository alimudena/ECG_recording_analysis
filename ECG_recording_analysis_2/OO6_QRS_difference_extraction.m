clc
clear
close all
%%1. Load the data of the file from the folder
folder = "experiments/VNS-011";
file = "r1_VNSc_agujas_01.12.25";
[t, stim, ECG, fs] = parameter_extraction(folder, file);
%% Select frequencies, timing restrictions for plotting and thresholds 
% Para los filtrados
f_low_pass = 250;
                                                            f0 = 20.3;     % Frequency of the stimulation
f_high_pass = 1;
f_max = 500;

highpass_filter_order = 4;
Q = 50;          % Queality factor (higher = thiner)

f_max_plot = 5000;
f_max_plot_small = 100;

% Para el moving average
window_ms = 15; 
window_samples = round(window_ms * 1e-4 * fs);  

% Para las ppm

t_min = 850;
                                                                        th_ECG_inf = 50;
peak_distance = 0.08*fs;

ventana_segundos = 3;
delta_t_segundos = 0.5;

% S extraction timing
S_to_R_min_distance = 0;
S_to_R_max_distance = 0.015;

% Q extraction timing 
Q_to_R_min_distance = 0;
Q_to_R_max_distance = 0.01;

% P extraction timing
P_to_R_min_distance = 0.01;
P_to_R_max_distance = 0.1;

% T extraction timing
T_to_R_min_distance = 0.02;
T_to_R_max_distance = 0.15;


%% Show ECG signal with and without stimulation and FFT
t_no_stim = [1: 100000];
t_stim = [4010000:4110000];
show_with_without_stim(ECG, f0, fs, t, t_no_stim, t_stim);

%% Filtering of 50 Hz
[b,ppm] = iirnotch(50/(fs/2), 50/(fs/2)/Q);
ecg_filtered_50Hz = filtfilt(b,ppm, ECG);
% filter_show(fs, Q)

%% Low pass filter at f_low_pass
[ecg_filtered_low_pass, filt] = lowpass(ecg_filtered_50Hz, f_low_pass, fs, ImpulseResponse="iir", Steepness=0.95);

%% High pass filter with Butterworth
Wn = f_high_pass / (fs/2);   
[b_hpf, ppm_hpf] = butter(4, Wn, 'high');

ecg_filtered_band_pass = filtfilt(b_hpf, ppm_hpf, ecg_filtered_low_pass);


%% Stimulation frequency elimination
% --- Harmonic Notch filtering---
harmonics = f0:f0:f_max;
ecg_filtered_harmonics = ecg_filtered_band_pass;
for f = harmonics
    % Avoid Notch at Nyquist exact (not valid)
    if f >= fs/2
        continue;
    end
    wo = f/(fs/2);        % frecuencia normalizada
    bw = wo/Q;            % ancho de banda normalizado
    [b, ppm] = iirnotch(wo, bw);
    ecg_filtered_harmonics = filtfilt(b, ppm, ecg_filtered_harmonics);  % filtrado en ambas direcciones
end



%% Derivative (Pan–Tompkins, FIR 5 puntos, ganancia 0.1, retardo 2 muestras)
% H(z) = 0.1(-z^-2 - 2z^-1 + 2z^1 + z^2)
% En tiempo: y[n] = 0.1(-x[n-2] - 2x[n-1] + 2x[n+1] + x[n+2])
% Usamos filtfilt para evitar desfase (corrige el retardo de 2 muestras)

b_der = 0.1 * [-1 -2 0 2 1];  % Coeficientes FIR (causales con delay de 2)
derivative = filtfilt(b_der, 1, ecg_filtered_harmonics) * fs;

%% Squared signal
derivative_squared = derivative.^2;
%% Moving Window Integration (MWI)

% Crear ventana rectangular normalizada
mwi_kernel = ones(window_samples, 1) / window_samples;

% Aplicar convolución para integración móvil
mwi_signal = conv(derivative_squared, mwi_kernel, 'same');

%% Peaks finding for mwi_signal
[A, R_locs]  = findpeaks(mwi_signal, 'MinPeakHeight', th_ECG_inf, 'MinPeakDistance', peak_distance);
A_T = R_locs;
R_locs = zeros(size(A_T));

search_win = round(0.01 * fs);  % 10 ms

for i = 1:length(A_T)
    idx = A_T(i);

    w_start = max(1, idx - search_win);
    w_end   = min(length(ecg_filtered_harmonics), idx + search_win);

    [~, r_idx] = max(ecg_filtered_harmonics(w_start:w_end));
    R_locs(i) = w_start + r_idx - 1;
end


%% Calculation of bpm with MWI signal beat by beat
RR = diff(R_locs) / fs;  % en segundos
ppm_RR = 60 ./ RR;    % bpm
t_R = R_locs / fs;    % tiempos de los picos R
t_ppm = t_R(2:end);    % tiempos correspondientes a cada RR


%% ------------------------ ECG AND BPM ------------------------ 

figure;
% --- ECG left axis---
yyaxis left
plot(t, ECG);
xlabel('Time (s)');
ylabel('ECG (mV)');
grid on
hold on

% --- BPM right axis---
yyaxis right
plot(t_ppm, ppm_RR, 'MarkerSize', 12);
ylabel('BPM');
title('ECG with BPM beat by beat (RR)');


%% S localization on real ECG using Hilbert Transform

% Analytic signal via Hilbert transform
analytic_signal = hilbert(ecg_filtered_harmonics);
hilbert_env = abs(analytic_signal);     % Envelope

% Parámetros fisiológicos
S_min_distance_samples = round(S_to_R_min_distance * fs);   % mínimo después de R
S_max_distance_samples = round(S_to_R_max_distance * fs);  % buscar hasta 150 ms después

S_locs = [];
S_vals = [];

for i = 1:length(R_locs)

    % Ventana de búsqueda para el pico S
    left = R_locs(i) + S_min_distance_samples;
    right = min(R_locs(i) + S_max_distance_samples, length(ecg_filtered_harmonics));
    
    if left >= length(ecg_filtered_harmonics)
        continue;
    end

    % Recorte de señal
    segment = ecg_filtered_harmonics(left:right);

    % Usamos la envolvente de Hilbert para detectar mínimos locales
    segment_env = hilbert_env(left:right);

    % Buscar un mínimo local en esa ventana
    [~, idx_min_hilbert] = min(segment_env);
    [~, idx_min] = min(segment);
    % Y comparar los mínimos obtenidos tanto con hilbert como con la
    % filtrada
    if(segment(idx_min_hilbert)<segment(idx_min))
        idx_min = idx_min_hilbert;
    end

    % Convertir a posición absoluta
    S_loc = left + idx_min - 1;

    S_locs(i) = S_loc;
    S_vals(i) = ecg_filtered_harmonics(S_loc);
end

%% Q localization using Hilbert transform

% Parámetros fisiológicos
Q_min_distance_samples = round(Q_to_R_min_distance * fs);   % mínimo antes de R
Q_max_distance_samples = round(Q_to_R_max_distance * fs);  % máximo antes de R

Q_locs = [];

for i = 1:length(R_locs)

    % Ventana de búsqueda para el pico S
    left = R_locs(i) - Q_max_distance_samples;
    right = min(R_locs(i) - Q_min_distance_samples, length(ecg_filtered_harmonics));
    
    if right >= length(ecg_filtered_harmonics)
        continue;
    end
    if left <= 0
        continue;
    end

    % Recorte de señal
    segment = ecg_filtered_harmonics(left:right);

    % Usamos la envolvente de Hilbert para detectar mínimos locales
    segment_env = hilbert_env(left:right);

    % Buscar un mínimo local en esa ventana
    [~, idx_min_hilbert] = min(segment_env);
    [~, idx_min] = min(segment);
    % Y comparar los mínimos obtenidos tanto con hilbert como con la
    % filtrada
    if(segment(idx_min_hilbert)<segment(idx_min))
        idx_min = idx_min_hilbert;
    end

    % Convertir a posición absoluta
    Q_loc = left + idx_min - 1;

    Q_locs(i) = Q_loc;
end

%% P localization using Hilbert transform

% Parámetros fisiológicos
P_min_distance_samples = round(P_to_R_min_distance * fs);   % mínimo antes de R
P_max_distance_samples = round(P_to_R_max_distance * fs);  % máximo antes de R

P_locs = [];

for i = 1:length(R_locs)

    % Ventana de búsqueda para el pico S
    left = R_locs(i) - P_max_distance_samples;
    right = min(R_locs(i) - P_min_distance_samples, length(ecg_filtered_harmonics));
    
    if right >= length(ecg_filtered_harmonics)
        continue;
    end
    if left <= 0
        continue;
    end

    % Recorte de señal
    segment = ecg_filtered_harmonics(left:right);

    % Usamos la envolvente de Hilbert para detectar mínimos locales
    segment_env = hilbert_env(left:right);

    % Buscar un mínimo local en esa ventana
    [~, idx_min_hilbert] = max(segment_env);
    [~, idx_min] = max(segment);
    % Y comparar los mínimos obtenidos tanto con hilbert como con la
    % filtrada
    if(segment(idx_min_hilbert)<segment(idx_min))
        idx_min = idx_min_hilbert;
    end

    % Convertir a posición absoluta
    P_loc = left + idx_min - 1;

    P_locs(i) = P_loc;
end

%% T localization using Hilbert transform

% Parámetros fisiológicos
T_min_distance_samples = round(T_to_R_min_distance * fs);   % mínimo antes de R
T_max_distance_samples = round(T_to_R_max_distance * fs);  % máximo antes de R

T_locs = [];

for i = 1:length(R_locs)

    % Ventana de búsqueda para el pico S
    left = R_locs(i) + T_min_distance_samples;
    right = min(R_locs(i) + T_max_distance_samples, length(ecg_filtered_harmonics));
    
    if right >= length(ecg_filtered_harmonics)
        continue;
    end
    if left <= 0
        continue;
    end

    % Recorte de señal
    segment = ecg_filtered_harmonics(left:right);

    % Usamos la envolvente de Hilbert para detectar mínimos locales
    segment_env = hilbert_env(left:right);

    % % Buscar un mínimo local en esa ventana
    % [~, idx_min_hilbert] = max(segment_env);
    % [~, idx_min] = max(segment);
    % % Y comparar los mínimos obtenidos tanto con hilbert como con la
    % % filtrada
    % if(segment(idx_min_hilbert)<segment(idx_min))
    %     idx_min = idx_min_hilbert;
    % end
    [~, idx_min] = max(segment_env);

    % Convertir a posición absoluta
    T_loc = left + idx_min - 1;

    T_locs(i) = T_loc;
end

%%Ajuste fijo para T
A_T = T_locs;
T_locs = zeros(size(A_T));

search_win = round(0.01 * fs);  % 10 ms

for i = 1:length(A_T)
    idx = A_T(i);

    w_start = max(1, idx - search_win);
    w_end   = min(length(ecg_filtered_harmonics), idx + search_win);

    [~, r_idx] = max(ecg_filtered_harmonics(w_start:w_end));
    T_locs(i) = w_start + r_idx - 1;
end

%% Plot para verificar detección
figure;
hold on;
plot(t, ecg_filtered_harmonics); 
plot(t, hilbert_env);
plot(t(R_locs), ecg_filtered_harmonics(R_locs), 'ro', 'LineWidth', 1.5);
plot(t(S_locs), ecg_filtered_harmonics(S_locs), 'ko', 'LineWidth', 1.5);
plot(t(Q_locs(2:end)), ecg_filtered_harmonics(Q_locs(2:end)), 'go', 'LineWidth', 1.5);
plot(t(P_locs(2:end)), ecg_filtered_harmonics(P_locs(2:end)), 'bo', 'LineWidth', 1.5);
plot(t(T_locs(2:end)), ecg_filtered_harmonics(T_locs(2:end)), 'co', 'LineWidth', 1.5);
yyaxis right
% plot(t_ppm, ppm_RR, 'MarkerSize', 2);
ylim([200, 400])
legend('ECG filtrado','hilbert','Picos R','Picos S', 'Q', 'P', 'T');
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Detección de PQRST mediante Transformada de Hilbert');
grid on;
%% Parameters difference extraction
% PP bpm
PP = diff(P_locs) / fs;  % en segundos
ppm_PP = 60 ./ PP;    % bpm
t_PP = P_locs(1:end-1) / fs;    % tiempos de los picos R

% QQ bpm
QQ = diff(Q_locs) / fs;  % en segundos
ppm_QQ = 60 ./ QQ;    % bpm
t_QQ = Q_locs(1:end-1) / fs;    % tiempos de los picos R


% RR bpm
RR = diff(R_locs) / fs;  % en segundos
ppm_RR = 60 ./ RR;    % bpm
t_RR = R_locs(1:end-1) / fs;    % tiempos de los picos R

% SS bpm
SS = diff(S_locs) / fs;  % en segundos
ppm_SS = 60 ./ SS;    % bpm
t_SS = S_locs(1:end-1) / fs;    % tiempos de los picos R

% TT
TT = diff(T_locs) / fs;  % en segundos
ppm_TT = 60 ./ TT;    % bpm
t_TT = T_locs(1:end-1) / fs;    % tiempos de los picos R



figure;
tiledlayout(5, 1, "TileSpacing", "compact", "Padding", "compact");

ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
hold on;
plot(t, ecg_filtered_harmonics); 
yyaxis right
hold on
plot(t_PP, ppm_PP)
legend("ECG", "PP bpm")
title("PP en bpm")
ylim([200, 400])
hold off


ax2 = nexttile;
hold on;
plot(t, ecg_filtered_harmonics); 
yyaxis right
hold on
plot(t_QQ, ppm_QQ)
legend("ECG", "QQ bpm")
title("QQ en bpm")
ylim([200, 400])
hold off


ax3 = nexttile;
hold on;
plot(t, ecg_filtered_harmonics); 
yyaxis right
hold on
plot(t_RR, ppm_RR)
legend("ECG", "RR bpm")
title("RR en bpm")
ylim([200, 400])
hold off


ax4 = nexttile;
hold on;
plot(t, ecg_filtered_harmonics); 
yyaxis right
hold on
plot(t_SS, ppm_SS)
legend("ECG", "SS bpm")
title("SS en bpm")
ylim([200, 400])
hold off


ax5 = nexttile;
hold on;
plot(t, ecg_filtered_harmonics); 
yyaxis right
hold on
plot(t_TT, ppm_TT)
legend("ECG", "TT bpm")
title("TT en bpm")
ylim([200, 400])
hold off

%%

figure
hold on
plot(t, ECG, 'DisplayName', 'ECG')
ylabel('mV')
yyaxis right
plot(t_PP, PP, 'DisplayName', 'PP')
% plot(t_TT, TT, 'g-', 'DisplayName', 'TT')
plot(t_QQ, QQ, 'k-', 'DisplayName', 'QQ')
plot(t_RR, RR, 'r-', 'DisplayName', 'RR')
plot(t_SS, SS, 'c-', 'DisplayName', 'SS')
ylabel('Seconds')
legend
title("Difference in time of all parameters")
xlabel('Time')

%%
%P-Q
PQ = (Q_locs-P_locs)/fs;
t_PQ = P_locs(1:end) / fs;    % tiempos de los picos R

%P-R
PR = (R_locs'-P_locs)/fs;
t_PR = P_locs(1:end) / fs;    % tiempos de los picos R

%P-S
PS = (S_locs-P_locs)/fs;
t_PS = P_locs(1:end) / fs;    % tiempos de los picos R

%P-T
PT = (T_locs-P_locs)/fs;
t_PT = P_locs(1:end) / fs;    % tiempos de los picos R



figure;
tiledlayout(4, 1, "TileSpacing", "compact", "Padding", "compact");

ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
hold on;
plot(t, ECG); 
yyaxis right
hold on
plot(t_PQ, PQ)
legend("ECG", "PQ")
title("PQ")
ylim([0.02, 0.06])

hold off


ax2 = nexttile;
hold on;
plot(t, ECG); 
yyaxis right
hold on
plot(t_PR, PR)
legend("ECG", "PR")
title("PR")
ylim([0.04, 0.06])
hold off

ax3 = nexttile;
hold on;
plot(t, ECG); 
yyaxis right
hold on
plot(t_PS, PS)
ylim([0.04, 0.06])
legend("ECG", "PS")
title("PS")
hold off

ax4 = nexttile;
hold on;
plot(t, ECG); 
yyaxis right
hold on
plot(t_PT, PT)
ylim([0.05, 0.15])
legend("ECG", "PT")
title("PT")
hold off



%%
%Q-R 
QR = (R_locs'-Q_locs)/fs;
t_QR = Q_locs(1:end) / fs;    % tiempos de los picos R

%Q-S
QS = (S_locs-Q_locs)/fs;
t_QS = Q_locs(1:end) / fs;    % tiempos de los picos R

%Q-T
QT = (T_locs-Q_locs)/fs;
t_QT = Q_locs(1:end) / fs;    % tiempos de los picos R




figure;
tiledlayout(3, 1, "TileSpacing", "compact", "Padding", "compact");

ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
hold on;
plot(t, ECG); 
yyaxis right
hold on
plot(t_QR, QR)
legend("ECG", "QR")
title("QR")
ylim([0.002, 0.010])

hold off
ax2 = nexttile;
hold on;
plot(t, ECG); 
yyaxis right
hold on
plot(t_QS, QS)
legend("ECG", "QS")
title("QS")
ylim([0.004, 0.015])
hold off

ax3 = nexttile;
hold on;
plot(t, ECG); 
yyaxis right
hold on
plot(t_QT, QT)
ylim([0.045, 0.07])
legend("ECG", "QT")
title("QT")
hold off

%%
%R-S 
RS = (S_locs-R_locs')/fs;
t_RS = R_locs(1:end) / fs;    % tiempos de los picos R

%R-T
RT = (T_locs-R_locs')/fs;
t_RT = R_locs(1:end) / fs;    % tiempos de los picos R

%S-T
ST = (T_locs-S_locs)/fs;
t_ST = S_locs(1:end) / fs;    % tiempos de los picos R


figure;
tiledlayout(3, 1, "TileSpacing", "compact", "Padding", "compact");

ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
hold on;
plot(t, ECG); 
yyaxis right
hold on
plot(t_RS, RS)
legend("ECG", "RS")
title("RS")
ylim([0.002, 0.005])

hold off
ax2 = nexttile;
hold on;
plot(t, ECG); 
yyaxis right
hold on
plot(t_RT, RT)
legend("ECG", "RT")
title("RT")
ylim([0.05, 0.055])
hold off

ax3 = nexttile;
hold on;
plot(t, ECG); 
yyaxis right
hold on
plot(t_ST, ST)
ylim([0.045, 0.055])
legend("ECG", "ST")
title("ST")
hold off