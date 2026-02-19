clc
clear
close all
%%1. Load the data of the file from the folder
folder = "experiments/VNS-011";
file = "r1_VNSc_agujas_01.12.25";
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
f0 = 7.02;     % Frequency of the noise
f_high_pass = 1;
f_max = 500;

highpass_filter_order = 4;
Q = 200;          % Queality factor (higher = thiner)

f_max_plot = 5000;
f_max_plot_small = 100;

% Para el moving average
window_ms = 15; 
window_samples = round(window_ms * 1e-3 * fs);  

% Para las ppm

t_min = 850;
th_ECG_inf = 50;
peak_distance = 0.1*fs;

ventana_segundos = 3;
delta_t_segundos = 0.5;


%% Cálculo de FFT y primera fila de gráficos
[fft_value, f_figure] = fft_calculation(ECG([1: 100000]), fs);

figure;
analisis_espectral = tiledlayout(2, 2, "TileSpacing", "compact", "Padding", "compact");

% --- Fila 1: señal original ---
ax1 = nexttile([1 1]);
plot(t([1: 100000]), ECG([1: 100000]));
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
[fft_value, f_figure] = fft_calculation(ECG([4010000:4110000]), fs);

% --- Fila 2: señal con estimulación ---
ax3 = nexttile([1 1]);
plot(t([4010000:4110000]), ECG([4010000:4110000]));
title(ax3, 'ECG with stimulation');
xlabel(ax3, 'Time [s]');
ylabel(ax3, 'Amplitude');
xlim([401, 411])

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

%%
wo = 50/(fs/2);
bw = wo/Q;
[b_notch, a_notch] = iirnotch(wo, bw);

fig = figure;
freqz(b_notch, a_notch, 4096, fs);
title('50 Hz Notch filter');

ax = findall(fig, 'Type', 'axes');
arrayfun(@(a) xlim(a, [0 0.2]), ax);




%% Low pass filter at f_low_pass
[ecg_filtered_low_pass, filt] = lowpass(ecg_filtered_50Hz, f_low_pass, fs, ImpulseResponse="iir", Steepness=0.95);

%%

% % Número de puntos para la FFT
% N = 40960;
% 
% % Respuesta en frecuencia del filtro
% [H_lpf, f] = freqz(filt, N, fs);  % 'fs' para tener el eje en Hz
% 
% % Gráficas de módulo (en dB) y fase (en grados)
% figure;
% subplot(2,1,1);
% plot(f, 20*log10(abs(H_lpf)), 'LineWidth', 1.5);
% grid on; xlim([0 500]);
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');
% title('Low pass filter');
% 
% subplot(2,1,2);
% plot(f, unwrap(angle(H_lpf))*180/pi, 'LineWidth', 1.5);
% grid on; xlim([0 500]);
% xlabel('Frequency (Hz)');
% ylabel('Phase (degrees)');
% title('Phase');


%% High pass filter with Butterworth
Wn = f_high_pass / (fs/2);   
[b_hpf, ppm_hpf] = butter(4, Wn, 'high');

ecg_filtered_band_pass = filtfilt(b_hpf, ppm_hpf, ecg_filtered_low_pass);

%%
% fig2 = figure;
% freqz(b_hpf, ppm_hpf, 4096, fs);
% ax = findall(fig2, 'Type', 'axes');
% arrayfun(@(a) xlim(a, [0 0.2]), ax);
% title('High pass filter');




%%
% % Esquema: 3 filas x 2 columnas
% % - Fila 1: 1 gráfico que ocupa las 2 columnas (horizontal)
% % - Filas 2 y 3: 4 gráficos (2 por fila, 2 columnas)
% 
% [fft_value_50, f_figure_50] = fft_calculation(ecg_filtered_50Hz, fs);
% [fft_value_BP, f_figure_BP] = fft_calculation(ecg_filtered_band_pass, fs);
% 
% figure;
% grafico_comparativo = tiledlayout(2, 2, "TileSpacing", "compact", "Padding", "compact");
% 
% ax1 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% plot(t, ecg_filtered_50Hz);
% title(ax1, 'ECG filtered 50 Hz');
% xlabel(ax1, 'Time [s]');
% ylabel(ax1, 'Amplitude');
% xlim([0, max(t)])
% 
% ax2 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% plot(f_figure_50, fft_value_50);
% title(ax2, 'ECG filtered 50 Hz');
% xlabel(ax2, 'Frequency (Hz)');
% ylabel(ax2, '|X(f)|');
% xlim([0, f_max_plot])
% 
% 
% ax3 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% plot(t, ecg_filtered_band_pass);
% title(ax3, 'ECG filtered with band pass filter');
% xlabel(ax3, 'Time [s]');
% ylabel(ax3, 'Amplitude');
% xlim([0, max(t)])
% 
% 
% ax4 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% plot(f_figure_BP, fft_value_BP);
% title(ax4, 'ECG filtered with band pass filter');
% xlabel(ax4, 'Frequency (Hz)');
% ylabel(ax4, '|X(f)|');
% xlim([0, f_max_plot])


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

%%
% figure; hold on;
% for f = harmonics
%     if f >= fs/2
%         continue;
%     end
%     wo = f/(fs/2);
%     bw = wo/Q;
%     [b, a] = iirnotch(wo, bw);
%     [h, w] = freqz(b, a, 409600, fs);
%     plot(w, 20*log10(abs(h)));
% end
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');
% title('Stimulation and harmonics filters');
% grid on;
% xlim([0, 500])

%% 


% [fft_value_harm, f_figure_harm] = fft_calculation(ecg_filtered_harmonics, fs);
% [fft_value_BP, f_figure_BP] = fft_calculation(ecg_filtered_band_pass, fs);
% 
% figure;
% grafico_comparativo = tiledlayout(2, 2, "TileSpacing", "compact", "Padding", "compact");
% 
% 
% ax3 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% plot(t, ecg_filtered_band_pass);
% title(ax3, 'ECG filtered with band pass filter');
% xlabel(ax3, 'Time [s]');
% ylabel(ax3, 'Amplitude');
% xlim([0, max(t)])
% 
% 
% ax4 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% plot(f_figure_BP, fft_value_BP);
% title(ax4, 'ECG filtered with band pass filter');
% xlabel(ax4, 'Frequency (Hz)');
% ylabel(ax4, '|X(f)|');
% xlim([0, 1500])
% 
% 
% ax5 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% plot(t, ecg_filtered_harmonics);
% title(ax5, 'ECG filtered stimulation and harmonics');
% xlabel(ax5, 'Time [s]');
% ylabel(ax5, 'Amplitude');
% xlim([0, max(t)])
% 
% ax6 = nexttile([1 1]);  % [rowspan colspan] -> ocupa 1 fila y 2 columnas
% plot(f_figure_harm, fft_value_harm);
% title(ax6, 'ECG filtered stimulation and harmonics');
% xlabel(ax6, 'Frequency (Hz)');
% ylabel(ax6, '|X(f)|');
% xlim([0, 1500])

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
%%
plot_together('ECG', f_max_plot_small, f_figure, fft_value, ECG, t)

%% 50 Hz filtered visualization
[fft_value, f_figure] = fft_calculation(ecg_filtered_50Hz, fs);
fft_plot('ECG filtered 50 Hz', f_max_plot, f_max_plot_small, f_figure, fft_value)
%%Visualization of the ECG 
ECG_visualization(ecg_filtered_50Hz, t, "ECG filtered 50 Hz");
%%
plot_together('ECG filtered 50 Hz', f_max_plot_small, f_figure, fft_value, ecg_filtered_50Hz, t)
%%
[fft_value, f_figure] = fft_calculation(ecg_filtered_band_pass, fs);
fft_plot('ecg_filtered_band_pass', f_max_plot, f_max_plot_small, f_figure, fft_value)
%%Visualization of the ECG 
ECG_visualization(ecg_filtered_band_pass, t, "ecg_filtered_band_pass");
%%
[fft_value, f_figure] = fft_calculation(ecg_filtered_harmonics, fs);
fft_plot('ecg_filtered_harmonics', f_max_plot, f_max_plot_small, f_figure, fft_value)
%%Visualization of the ECG 
ECG_visualization(ecg_filtered_harmonics, t, "ecg_filtered_harmonics");
%%
[fft_value, f_figure] = fft_calculation(derivative, fs);
fft_plot('derivative', f_max_plot, f_max_plot_small, f_figure, fft_value)
%%Visualization of the ECG 
ECG_visualization(derivative, t, "derivative");
%%
[fft_value, f_figure] = fft_calculation(mwi_signal, fs);
fft_plot('mwi_signal', f_max_plot, f_max_plot_small, f_figure, fft_value)
%%Visualization of the ECG 
ECG_visualization(mwi_signal, t, "mwi_signal");
%%
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
%%
% --- BPM right axis---
yyaxis right
plot(t_ppm, ppm_rr, 'MarkerSize', 12);
ylabel('BPM');
ylim([0, 1200])

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


%% ENVELOPE EXTRACTION
% Extraction of the stimulation signal based on high pass filtering the ECG
fecg = 1000;   % Frecuencia típica ECG

% Pasa altos para eliminar ECG
fc_hp = 100;
[b,a] = butter(4, fc_hp/(fecg/2), 'high');
s_hp = filtfilt(b,a,ECG);

% envolvente = abs(hilbert(s_hp));
envolvente = movmean(abs(s_hp), round(0.001*fs));


fc_lp = 10;   % mucho menor que la frecuencia del ruido
[b2,a2] = butter(4, fc_lp/(fs/2));
env_suave = filtfilt(b2,a2,envolvente);
% o filtfilt(b2,a2,energia)

%%
win = round(5*fs); % 1 s
env_win = movmean(env_suave, win);

stim_bin = env_win > Th_on;


%%
figure
plot(s_hp)
hold on
plot(stim_bin)
ylim([-1, 2])


%% sin eliminar 1 segundo
N = length(RR);
estado_RR = zeros(N,1);   % 1 = stim, 0 = reposo

for i = 1:N
    ini = A_T(i);
    fin = A_T(i+1);
    fin = min(fin, length(stim_bin));

    estado_RR(i) = mean(stim_bin(ini:fin)) > 0.5;
end

%%
cambios = [1; find(diff(estado_RR) ~= 0) + 1; N+1];

media_RR_stim   = [];
media_RR_reposo = [];

for k = 1:length(cambios)-1
    idx = cambios(k):cambios(k+1)-1;

    if estado_RR(idx(1)) == 1
        media_RR_stim(end+1) = mean(RR(idx));
    else
        media_RR_reposo(end+1) = mean(RR(idx));
    end
end

%%
media_RR_stim
media_RR_reposo


