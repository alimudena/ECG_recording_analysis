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
                                                                        th_ECG_inf = 100;
peak_distance = 0.08*fs;

ventana_segundos = 3;
delta_t_segundos = 0.5;

% Q extraction timing 
Q_to_R_min_distance = 0.1;

% S extraction timing
S_to_R_min_distance = 0.1;

% T extraction timing
T_to_S_minimum = 0.005;
T_to_R_maximum = 0.01;
T_to_S_maximum = 0.06;

% P extraction timing
P_to_R_minimum = 0.01;
P_to_R_maximum = 0.1;

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
[A, R_locs] = findpeaks(mwi_signal, 'MinPeakHeight', th_ECG_inf, 'MinPeakDistance', peak_distance);


%% Calculation of bpm with MWI signal beat by beat
RR = diff(R_locs) / fs;  % en segundos
ppm_rr = 60 ./ RR;    % bpm
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
plot(t_ppm, ppm_rr, 'MarkerSize', 12);
ylabel('BPM');
title('ECG with BPM beat by beat (RR)');
%% Visualization of all together


% Esquema: 3 filas x 2 columnas
% - Fila 1: 1 gráfico que ocupa las 2 columnas (horizontal)
% - Filas 2 y 3: 4 gráficos (2 por fila, 2 columnas)

figure;
tiledlayout(3, 2, "TileSpacing", "compact", "Padding", "compact");

% --- Fila 1: gráfico horizontal (ocupa 2 columnas) ---
ax1 = nexttile([1 2]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
plot(t, ECG);
title(ax1, 'Original ECG');
xlabel(ax1, 'Time [s]');
ylabel(ax1, 'Amplitude');
xlim([t_min, t_min+1.5])
ylim([-0.8, .8])

% --- Fila 2, columna 1 ---
ax2 = nexttile;
plot(t, ecg_filtered_harmonics);
title(ax2, 'Stimulation and harmonics filtered');
xlabel(ax2, 'Time [s]');
ylabel(ax2, 'Y');
xlim([t_min, t_min+1.5])
ylim([-0.8, .8])

% --- Fila 2, columna 2 ---
ax3 = nexttile;
plot(t, derivative);
title(ax3, 'Derivative filtered');
xlabel(ax3, 'Time [s]');
ylabel(ax3, 'Amplitude');
xlim([t_min, t_min+1.5])
ylim([-30, 30])

% --- Fila 3, columna 1 ---
ax4 = nexttile;
plot(t, derivative_squared);
title(ax4, 'Squared');
xlabel(ax4, 'Time [s]');
ylabel(ax4, 'Amplitude');
xlim([t_min, t_min+1.5])
% ylim([-0.4, .8])

% --- Fila 3, columna 2 ---
ax5 = nexttile;
plot(t, mwi_signal);
title(ax5, 'Peak extraction');
xlabel(ax5, 'Time [s]');
ylabel(ax5, 'Amplitude');
xlim([t_min, t_min+1.5])
hold on
plot(t(R_locs), mwi_signal(R_locs), '*');
yline(th_ECG_inf, '--r', 'Threshold');
hold off


%% R localization on real ECG
R_locs = zeros(size(R_locs));

search_win = round(0.01 * fs);  % 10 ms

for i = 1:length(R_locs)
    idx = R_locs(i);

    w_start = max(1, idx - search_win);
    w_end   = min(length(ecg_filtered_harmonics), idx + search_win);

    [~, r_idx] = max(ecg_filtered_harmonics(w_start:w_end));
    R_locs(i) = w_start + r_idx - 1;
end
%% QRS localization
Q_locs = zeros(size(R_locs));
S_locs = zeros(size(R_locs));

q_win = round(Q_to_R_min_distance * fs);  % 10 ms
s_win = round(S_to_R_min_distance  * fs);

for i = 1:length(R_locs)
    r = R_locs(i);

    % ---------- Q ----------
    q_start = max(1, r - q_win);
    q_end   = r;

    [~, q_idx] = min(ecg_filtered_harmonics(q_start:q_end));
    Q_locs(i) = q_start + q_idx - 1;

    % ---------- S ----------
    s_start = r;
    s_end   = min(length(ecg_filtered_harmonics), r + s_win);

    [~, s_idx] = min(ecg_filtered_harmonics(s_start:s_end));
    S_locs(i) = s_start + s_idx - 1;
end


%% T localization
%first filter the ECG for PT better localization
ecg_PT = bandpass(ecg_filtered_harmonics, [1 60], fs);
%%
% T localization
T_locs = zeros(size(R_locs)-1);

for i = 1:length(R_locs)-1   % hasta el penúltimo
    s = S_locs(i);

    t_start = s + round(T_to_S_minimum * fs);
    t_end   = min(R_locs(i+1) - round(T_to_R_maximum * fs), s + round(T_to_S_maximum * fs));

    if t_start >= t_end
        continue
    end

    % [~, idx] = max(ecg_PT(t_start:t_end));
    [~, idx] = max(abs(ecg_filtered_harmonics(t_start:t_end)));
    T_locs(i) = t_start + idx - 1;
end

%% P localization
P_locs = nan(size(R_locs));

N = length(ecg_filtered_harmonics);

for i = 2:length(R_locs)
    r = R_locs(i);

    p_start = r - round(P_to_R_maximum*fs);
    p_end   = r - round(P_to_R_minimum*fs);

    % Protección TOTAL de índices
    p_start = max(1, p_start);
    p_end   = min(N, p_end);

    if p_start >= p_end
        continue
    end

    segment = ecg_filtered_harmonics(p_start:p_end);

    if all(isnan(segment)) || isempty(segment)
        continue
    end

    [~, idx] = max(abs(segment));
    P_locs(i) = p_start + idx - 1;
end

valid_P = ~isnan(P_locs);
%% Verification of the PQRST localizations
hold on
plot(t, ECG);
plot(t, ecg_filtered_harmonics, 'k');
plot(t(R_locs), ecg_filtered_harmonics(R_locs), 'r*', 'LineWidth', 3);
plot(t(P_locs(valid_P)), ecg_filtered_harmonics(P_locs(valid_P)), 'k*', 'LineWidth', 3);
plot(t(Q_locs), ecg_filtered_harmonics(Q_locs), 'g*', 'LineWidth', 3);
plot(t(S_locs), ecg_filtered_harmonics(S_locs), 'b*', 'LineWidth', 3);
plot(t(T_locs), ecg_filtered_harmonics(T_locs), 'c*', 'LineWidth', 3);
legend(["original", "filtered", "R", "P", "Q", "S", "T"]);
ylim([-1.5, 3])
title("No stimulation time")
hold off
%% Calculation of differences: QT
N = length(R_locs)-1;

Q_locs = Q_locs(1:N);
T_locs = T_locs(1:N);

QT_locs = (T_locs - Q_locs') / fs;

%% Verification of results
figure;
tiledlayout(3, 1, "TileSpacing", "compact", "Padding", "compact");

% --- Fila 1: gráfico horizontal (ocupa 2 columnas) ---
ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% --- ECG left axis---
yyaxis left
plot(t, ECG);
xlabel('Time (s)');
ylabel('ECG (mV)');
grid on
hold on

% --- BPM right axis---
yyaxis right
plot(t_ppm, ppm_rr, 'MarkerSize', 12);
ylabel('BPM');
title('ECG with BPM beat by beat (RR)');


ax2 = nexttile;
% --- ECG left axis---
yyaxis left
plot(t, ECG);
xlabel('Time (s)');
ylabel('ECG (mV)');
grid on
hold on

% --- BPM right axis---
yyaxis right
plot(t_ppm, QT_locs, 'MarkerSize', 12);
ylim([0, 0.2])
ylabel('QT ');
title('QT difference');



ax3 = nexttile;
% --- QRS ---
hold on
plot(t, ECG);
plot(t, ecg_filtered_harmonics, 'k');
plot(t(R_locs), ecg_filtered_harmonics(R_locs), 'r*', 'LineWidth', 3);
plot(t(P_locs(valid_P)), ecg_filtered_harmonics(P_locs(valid_P)), 'k*', 'LineWidth', 3);
plot(t(Q_locs), ecg_filtered_harmonics(Q_locs), 'g*', 'LineWidth', 3);
plot(t(S_locs), ecg_filtered_harmonics(S_locs), 'b*', 'LineWidth', 3);
plot(t(T_locs), ecg_filtered_harmonics(T_locs), 'c*', 'LineWidth', 3);
legend(["original", "filtered", "R", "P", "Q", "S", "T"]);
ylim([-1.5, 3])
title("No stimulation time")
hold off

linkaxes([ax1 ax2 ax3], 'x');
xlim([250, 251])

%% Calculation of differences: PR
N = min(length(R_locs), length(P_locs));

PR_locs = (P_locs(1:N)-R_locs(1:N)) / fs;

%% Verification of results
figure;
tiledlayout(2, 1, "TileSpacing", "compact", "Padding", "compact");

% --- Fila 1: gráfico horizontal (ocupa 2 columnas) ---
ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% --- ECG left axis---
yyaxis left
plot(t, ECG);
xlabel('Time (s)');
ylabel('ECG (mV)');
grid on
hold on

% --- BPM right axis---
yyaxis right
plot(t_ppm, ppm_rr, 'MarkerSize', 12);
ylabel('BPM');
title('ECG with BPM beat by beat (RR)');


ax2 = nexttile;
% --- ECG left axis---
yyaxis left
plot(t, ECG);
xlabel('Time (s)');
ylabel('ECG (mV)');
grid on
hold on

% --- BPM right axis---
yyaxis right
plot(t_ppm(1:N), PR_locs, 'MarkerSize', 12);
ylabel('PR');
title('PR difference');


linkaxes([ax1 ax2], 'x');


%% Calculation of differences: QRS
N = min(length(P_locs), length(R_locs));


PR_locs = (P_locs(1:N) - R_locs(1:N)) / fs;

%% Verification of results
figure;
grafico_general = tiledlayout(2, 1, "TileSpacing", "compact", "Padding", "compact");

% --- Fila 1: gráfico horizontal (ocupa 2 columnas) ---
ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% --- ECG left axis---
yyaxis left
plot(t, ECG);
xlabel('Time (s)');
ylabel('ECG (mV)');
grid on
hold on

% --- BPM right axis---
yyaxis right
plot(t_ppm, ppm_rr, 'MarkerSize', 12);
ylabel('BPM');
title('ECG with BPM beat by beat (RR)');


ax2 = nexttile;
% --- ECG left axis---
yyaxis left
plot(t, ECG);
xlabel('Time (s)');
ylabel('ECG (mV)');
grid on
hold on

% --- BPM right axis---
yyaxis right
plot(t_ppm(1:N), PR_locs(1:N), 'MarkerSize', 12);
ylabel('PR');
title('PR difference');


linkaxes([ax1 ax2], 'x');

%%

