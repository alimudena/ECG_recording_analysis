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
% 
% x_fill = [110, 140, 140, 110]; % Coordenadas X del polígono (dos puntos en x=2, dos en x=5)
% y_fill = [min(ylim), min(ylim), max(ylim), max(ylim)]; % Coordenadas Y (de abajo a arriba)
% fill(x_fill, y_fill, 'g', 'FaceAlpha', 0.3); % 'g' para verde, 0.3 para transparencia
% 
% x_fill = [300, 330, 330, 300]; % Coordenadas X del polígono (dos puntos en x=2, dos en x=5)
% y_fill = [min(ylim), min(ylim), max(ylim), max(ylim)]; % Coordenadas Y (de abajo a arriba)
% fill(x_fill, y_fill, 'g', 'FaceAlpha', 0.3); % 'g' para verde, 0.3 para transparencia
% 
% x_fill = [580, 610, 610, 580]; % Coordenadas X del polígono (dos puntos en x=2, dos en x=5)
% y_fill = [min(ylim), min(ylim), max(ylim), max(ylim)]; % Coordenadas Y (de abajo a arriba)
% fill(x_fill, y_fill, 'g', 'FaceAlpha', 0.3); % 'g' para verde, 0.3 para transparencia
% 
% 
% x_fill = [1005, 1035, 1035, 1005]; % Coordenadas X del polígono (dos puntos en x=2, dos en x=5)
% y_fill = [min(ylim), min(ylim), max(ylim), max(ylim)]; % Coordenadas Y (de abajo a arriba)
% fill(x_fill, y_fill, 'g', 'FaceAlpha', 0.3); % 'g' para verde, 0.3 para transparencia
% 
% x_fill = [1290, 1320, 1320, 1290]; % Coordenadas X del polígono (dos puntos en x=2, dos en x=5)
% y_fill = [min(ylim), min(ylim), max(ylim), max(ylim)]; % Coordenadas Y (de abajo a arriba)
% fill(x_fill, y_fill, 'g', 'FaceAlpha', 0.3); % 'g' para verde, 0.3 para transparencia
% 
% 
% x_fill = [45, 80, 80, 45]; % Coordenadas X del polígono (dos puntos en x=2, dos en x=5)
% y_fill = [min(ylim), min(ylim), max(ylim), max(ylim)]; % Coordenadas Y (de abajo a arriba)
% fill(x_fill, y_fill, 'r', 'FaceAlpha', 0.3); % 'g' para verde, 0.3 para transparencia
% 
% x_fill = [385, 430, 430, 385]; % Coordenadas X del polígono (dos puntos en x=2, dos en x=5)
% y_fill = [min(ylim), min(ylim), max(ylim), max(ylim)]; % Coordenadas Y (de abajo a arriba)
% fill(x_fill, y_fill, 'r', 'FaceAlpha', 0.3); % 'g' para verde, 0.3 para transparencia
% 
% x_fill = [1050, 1080, 1080, 1050]; % Coordenadas X del polígono (dos puntos en x=2, dos en x=5)
% y_fill = [min(ylim), min(ylim), max(ylim), max(ylim)]; % Coordenadas Y (de abajo a arriba)
% fill(x_fill, y_fill, 'r', 'FaceAlpha', 0.3); % 'g' para verde, 0.3 para transparencia
% 
% 
% x_fill = [715, 745, 745, 715]; % Coordenadas X del polígono (dos puntos en x=2, dos en x=5)
% y_fill = [min(ylim), min(ylim), max(ylim), max(ylim)]; % Coordenadas Y (de abajo a arriba)
% fill(x_fill, y_fill, 'r', 'FaceAlpha', 0.3); % 'g' para verde, 0.3 para transparencia
% 
% x_fill = [1380, 1410, 1410, 1380]; % Coordenadas X del polígono (dos puntos en x=2, dos en x=5)
% y_fill = [min(ylim), min(ylim), max(ylim), max(ylim)]; % Coordenadas Y (de abajo a arriba)
% fill(x_fill, y_fill, 'r', 'FaceAlpha', 0.3); % 'g' para verde, 0.3 para transparencia

%% 
% Bins fijos entre 200 y 350
bin_edges = linspace(200, 350, 100);  % 40 bins → 41 edges

figure;
tiledlayout(5, 1, "TileSpacing", "compact", "Padding", "compact");

% Histograma
ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas

t_start = 110;
t_end = 140;
idx = t_ppm >= t_start & t_ppm <= t_end;
ppm_segment = ppm_RR(idx);
histogram(ppm_segment, bin_edges, 'FaceColor', [0 0.4 0]);
title("No stim 1")
ylim([0, 30])

nexttile;
t_start = 300;
t_end = 330;
idx = t_ppm >= t_start & t_ppm <= t_end;
ppm_segment = ppm_RR(idx);
histogram(ppm_segment, bin_edges, 'FaceColor', [0 0.4 0.8]);
title("No stim 2")
ylim([0, 30])

nexttile;
t_start = 580;
t_end = 610;
idx = t_ppm >= t_start & t_ppm <= t_end;
ppm_segment = ppm_RR(idx);
histogram(ppm_segment, bin_edges, 'FaceColor', [0 0 0.8]);
title("No stim 3")
ylim([0, 30])

nexttile;
t_start = 1005;
t_end = 1035;
idx = t_ppm >= t_start & t_ppm <= t_end;
ppm_segment = ppm_RR(idx);
histogram(ppm_segment, bin_edges, 'FaceColor', [0 0 0]);
title("No stim 4")
ylim([0, 30])

nexttile;
t_start = 1290;
t_end = 1320;
idx = t_ppm >= t_start & t_ppm <= t_end;
ppm_segment = ppm_RR(idx);
histogram(ppm_segment, bin_edges, 'FaceColor', [0.5 0 0]);
title("No stim 5")
ylim([0, 30])
%% 
% Bins fijos entre 200 y 350

figure;
tiledlayout(5, 1, "TileSpacing", "compact", "Padding", "compact");

% Histograma
ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas

t_start = 45;
t_end = 80;
idx = t_ppm >= t_start & t_ppm <= t_end;
ppm_segment = ppm_RR(idx);
histogram(ppm_segment, bin_edges, 'FaceColor', [0 0.4 0]);
title("stim 1")
ylim([0, 30])

nexttile;
t_start = 385;
t_end = 430;
idx = t_ppm >= t_start & t_ppm <= t_end;
ppm_segment = ppm_RR(idx);
histogram(ppm_segment, bin_edges, 'FaceColor', [0 0.4 0.8]);
title("stim 2")
ylim([0, 30])

nexttile;
t_start = 715;
t_end = 745;
idx = t_ppm >= t_start & t_ppm <= t_end;
ppm_segment = ppm_RR(idx);
histogram(ppm_segment, bin_edges, 'FaceColor', [0 0 0.8]);
title("stim 3")
ylim([0, 30])

nexttile;
t_start = 1050;
t_end = 1080;
idx = t_ppm >= t_start & t_ppm <= t_end;
ppm_segment = ppm_RR(idx);
histogram(ppm_segment, bin_edges, 'FaceColor', [0 0 0]);
title("stim 4")
ylim([0, 30])

nexttile;
t_start = 1380;
t_end = 1410;
idx = t_ppm >= t_start & t_ppm <= t_end;
ppm_segment = ppm_RR(idx);
histogram(ppm_segment, bin_edges, 'FaceColor', [0.5 0 0]);
title("stim 5")
ylim([0, 30])

%% 
hist_ppm_in_window(t_ppm, ppm_RR, 400, 410, 250, 350, 90, 'Sí');
hist_ppm_in_window(t_ppm, ppm_RR, 1383, 1384, 250, 350, 90, 'Sí');
hist_ppm_in_window(t_ppm, ppm_RR, 800, 810, 250, 350, 90, 'No');
hist_ppm_in_window(t_ppm, ppm_RR, 200, 210, 250, 350, 90, 'No');


