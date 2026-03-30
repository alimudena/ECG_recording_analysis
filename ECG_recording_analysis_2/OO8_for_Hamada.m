clc
clear
close all
%%1. Load the data of the file from the folder
experiment_folder = "VNS-003";
folder = "experiments/"+experiment_folder;
file = "RATON4-30_+EST";
% Cargar el archivo
datos = load(folder+"/"+file+".mat");
%% Extract the ECG signal, the stimulation signal and the sampling frequency used.
signal = datos.signal;
fs = datos.sampling_rate;
ECG = -double(signal(:, 1));
stim = signal(:, 2);    
N = length(ECG);
%% Calculate the timing array and clear all the unnecesary data
t = (0:N-1)/fs;
clear signal;
clear datos;
close all;
clc;
%% Select frequencies, timing restrictions for plotting and thresholds 
% Para los filtrados
f_low_pass = 250;
f0 = 20.3;     % Frequency of the noise
f_high_pass = 1;
f_max = 500;

highpass_filter_order = 4;
Q = 50;          % Queality factor (higher = thiner)

f_max_plot = 5000;
f_max_plot_small = 100;

% Para el moving average
window_ms = 15; 
window_samples = round(window_ms * 1e-3 * fs);  

% Para las ppm

t_min = 850;
th_ECG_inf = 100;
peak_distance = 0.1*fs;

ventana_segundos = 3;
delta_t_segundos = 0.5;


%% Cálculo de FFT y primera fila de gráficos
[fft_value, f_figure] = fft_calculation(ECG([170*fs: 180*fs]), fs);

figure;
analisis_espectral = tiledlayout(2, 2, "TileSpacing", "compact", "Padding", "compact");

% --- Fila 1: señal original ---
ax1 = nexttile([1 1]);
plot(t([170*fs: 180*fs]), ECG([170*fs: 180*fs]));
title(ax1, 'Original ECG');
xlabel(ax1, 'Time [s]');
ylabel(ax1, 'Amplitude');

% --- Fila 1: FFT ---
ax2 = nexttile([1 1]);
plot(f_figure, fft_value);
title(ax2, 'FFT');
xlabel(ax2, 'Frequency [Hz]');
ylabel(ax2, 'Power');
xlim(ax2, [0, 500]);  % límite de visualización

% --- Marcador vertical en 50 Hz para la primera FFT ---
hold(ax2, 'on');
xline(ax2, 50, ':r', '50 Hz', 'LabelOrientation', 'horizontal', ...
      'LabelVerticalAlignment', 'middle', 'LineWidth', 0.8);
hold(ax2, 'off');

%%Nueva ventana temporal y su FFT
[fft_value, f_figure] = fft_calculation(ECG([365*fs: 375*fs]), fs);

% --- Fila 2: señal con estimulación ---
ax3 = nexttile([1 1]);
plot(t([365*fs: 375*fs]), ECG([365*fs: 375*fs]));
title(ax3, 'ECG with stimulation');
xlabel(ax3, 'Time [s]');
ylabel(ax3, 'Amplitude');
xlim([365, 375])

% --- Fila 2: FFT con estimulación ---
ax4 = nexttile([1 1]);
plot(f_figure, fft_value);
title(ax4, 'FFT with stimulation');
xlabel(ax4, 'Frequency [Hz]');
ylabel(ax4, 'Power');
xlim(ax4, [0, 500]);  % límite de visualización

% --- Marcadores: 50 Hz + todos los armónicos de 20 Hz (20,40,60,...) ---
hold(ax4, 'on');

% 50 Hz (mismo estilo que arriba)
xline(ax4, 50, ':r', '50 Hz', 'LabelOrientation', 'horizontal', ...
      'LabelVerticalAlignment', 'middle', 'LineWidth', 0.8);

% Armónicos de 20 Hz dentro del rango visible/datos
maxFreqVisible = min(0, max(f_figure));        % asegúrate de no salirte de los datos
harmonics20 = f0:f0:500;              % 20, 40, 60, ...
% (opcional) evita duplicar la etiqueta de 50 si coincide con un armónico
% pero se permite mantener 50 también como armónico si lo quieres ver doble.
% Aquí optamos por NO etiquetar cada armónico para no saturar:
xline(ax4, 20.2998, ':k', '20 Hz', 'LabelOrientation', 'horizontal', ...
      'LabelVerticalAlignment', 'top', 'LineWidth', 0.8);  % líneas punteadas negras
for h = harmonics20
    % usa un estilo distinto a 50 Hz para diferenciarlos
    if h == 50
        % ya está marcado arriba; si quieres que también se pinte como armónico, comenta el 'continue'
        continue;
    end
    xline(ax4, h, ':k', 'LineWidth', 0.8);  % líneas punteadas negras
end

% (opcional) leyenda sencilla para explicar el código de color/estilo


%% Filtering of 50 Hz
[b,ppm] = iirnotch(50/(fs/2), 50/(fs/2)/Q);
ecg_filtered_50Hz = filtfilt(b,ppm, ECG);

wo = 50/(fs/2);
bw = wo/Q;
[b_notch, a_notch] = iirnotch(wo, bw);

%% Low pass filter at f_low_pass
[ecg_filtered_low_pass, filt] = lowpass(ecg_filtered_50Hz, f_low_pass, fs, ImpulseResponse="iir", Steepness=0.95);



%%High pass filter with Butterworth
Wn = f_high_pass / (fs/2);   
[b_hpf, ppm_hpf] = butter(4, Wn, 'high');

ecg_filtered_band_pass = filtfilt(b_hpf, ppm_hpf, ecg_filtered_low_pass);


%%Stimulation frequency elimination
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

%%Squared signal
derivative_squared = derivative.^2;

%%Moving Window Integration (MWI)

% Crear ventana rectangular normalizada
mwi_kernel = ones(window_samples, 1) / window_samples;

% Aplicar convolución para integración móvil
mwi_signal = conv(derivative_squared, mwi_kernel, 'same');

%% Peaks finding for mwi_signal
[A, A_T]  = findpeaks(mwi_signal, 'MinPeakHeight', th_ECG_inf, 'MinPeakDistance', peak_distance);


%% Calculation of bpm with MWI signal beat by beat
RR = diff(A_T) / fs;  % en segundos
ppm_rr = 60 ./ RR;    % bpm
t_R = A_T / fs;    % tiempos de los picos R
t_ppm = t_R(2:end);    % tiempos correspondientes a cada RR

%% ------------------------ PLOTTING DIFFERENT FFTS------------------------ 
%%  RAW
[fft_value, f_figure] = fft_calculation(ECG, fs);
fft_plot('ECG', f_max_plot, f_max_plot_small, f_figure, fft_value)
%%Visualization of the ECG 
ECG_visualization(ECG, t, "ECG");


plot_with_peaks(mwi_signal, t, A_T, th_ECG_inf, ecg_filtered_harmonics);



%% ------------------------ ECG AND BPM ------------------------ 

figure;
% --- ECG left axis---
% yyaxis left
plot(t, ECG);
xlabel('Time (s)');
ylabel('ECG (mV)');
grid on
hold on
title('ECG with BPM beat by beat (RR)');

% --- BPM right axis---
yyaxis right
plot(t_ppm, ppm_rr, 'MarkerSize', 12);
ylabel('BPM');
ylim([0, 600])

%% Visualization of all together


% Esquema: 3 filas x 2 columnas
% - Fila 1: 1 gráfico que ocupa las 2 columnas (horizontal)
% - Filas 2 y 3: 4 gráficos (2 por fila, 2 columnas)

figure;
grafico_general = tiledlayout(3, 2, "TileSpacing", "compact", "Padding", "compact");

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
plot(t(A_T), mwi_signal(A_T), '*');
yline(th_ECG_inf, '--r', 'Threshold');
hold off


% Título general del conjunto de tiles
% title(grafico_general, 'ECG filtering for bpm calculation', 'FontWeight', 'bold', 40);


