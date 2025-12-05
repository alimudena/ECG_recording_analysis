clc
clear

%%1. Load the data of the file from the folder
folder = "raton";
file = "r5_izq_invasivo_aguja_roja_1mA";
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
f0 = 20.3293;     % Frequency of the noise
f_high_pass = 1;
f_max = f_low_pass + 50;

highpass_filter_order = 4;
Q = 200;          % Queality factor (higher = thiner)

f_max_plot = 5000;
f_max_plot_small = 100;

% Para el moving average
window_ms = 30; 
window_samples = round(window_ms * 1e-3 * fs);  

% Para las ppm

t_min = 850;
th_ECG_inf = 0.2;
peak_distance = 0.1*fs;

ventana_segundos = 10;
delta_t_segundos = 2;



%% fft calculation
N = length(ECG);

% Calculate FFT
X = fft(ECG); % Calculate spectrum magnitude
magX = abs(X)/N;     % Normalization
magX = magX(1:N/2+1); % positive half spectrum
magX(2:end-1) = 2*magX(2:end-1); % Compensate deleted energy
f_figure = (0:N/2)*fs/N; % Frequency vector
%% Plot fft of the signal with no filtering
figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Spectrum with no filtering');
xlim([0, f_max_plot])
grid on;

figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Spectrum with no filtering');
xlim([0, f_max_plot_small])
grid on;

%% Filtering of 50 Hz
[b,a] = iirnotch(50/(fs/2), 50/(fs/2)/Q);
ecg_filtered_50Hz = filtfilt(b,a, ECG);


%% fft calculation with 50Hz filtered
N = length(ecg_filtered_50Hz);
magX = abs(fft(ecg_filtered_50Hz))/N;     
magX = magX(1:N/2+1);
magX(2:end-1) = 2*magX(2:end-1);
f_figure = (0:N/2)*fs/N; % Frequency vector
%% Plot fft of the signal with 50Hz filtering
figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Spectrum with 50Hz filtering');
xlim([0, f_max_plot])
grid on;

figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Spectrum with 50Hz filtering');
xlim([0, f_max_plot_small])
grid on;

%% Visualization of the ECG filtered with 50Gz
figure
plot(t, ecg_filtered_50Hz);
title('ECG filtered with 50Hz filtering');
xlabel('Time (s)'); 
ylabel('Amplitud');
% xlim([t_min, t_min+20])


%% Low pass filter at f_low_pass
[ecg_filtered_low_pass, filt] = lowpass(ecg_filtered_50Hz, f_low_pass, fs, ImpulseResponse="iir", Steepness=0.95);


%% fft calculation with lowpass filtered
N = length(ecg_filtered_low_pass);
magX = abs(fft(ecg_filtered_low_pass))/N;     
magX = magX(1:N/2+1);
magX(2:end-1) = 2*magX(2:end-1);

%% Plot fft of the signal with lowpass filtered
figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Spectrum with lowpass filtering');
xlim([0, f_max_plot])
grid on;

figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Spectrum with lowpass filtering');
xlim([0, f_max_plot_small])
grid on;

%% Visualization of the ECG lowpass filtered 
figure
plot(t, ecg_filtered_low_pass);
title('ECG filtered with lowpass filtering');
xlabel('Time (s)'); 
ylabel('Amplitud');
% xlim([t_min, t_min+20])


%% High pass filter with Butterworth
Wn = f_high_pass / (fs/2);   
[b, a] = butter(4, Wn, 'high');

ecg_filtered_band_pass = filtfilt(b, a, ecg_filtered_low_pass);


%% fft calculation with band pass filtered
N = length(ecg_filtered_band_pass);
magX = abs(fft(ecg_filtered_band_pass))/N;     
magX = magX(1:N/2+1);
magX(2:end-1) = 2*magX(2:end-1);

%% Plot fft of the signal with band pass filtering
figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Spectrum with bandpass filtering');
xlim([0, f_max_plot])
grid on;

figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Sectrum with bandpass filtering');
xlim([0, f_max_plot_small])
grid on;

%% Visualization of the ECG filtered with band pass
figure
plot(t, ecg_filtered_band_pass);
title('ECG filtered with bandpass filtering');
xlabel('Time (s)'); 
ylabel('Amplitud');
% xlim([t_min, t_min+20])

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
    [b, a] = iirnotch(wo, bw);
    ecg_filtered_harmonics = filtfilt(b, a, ecg_filtered_harmonics);  % filtrado en ambas direcciones
end

%% fft calculation with stimulation noise extracted
N = length(ecg_filtered_harmonics);
magX = abs(fft(ecg_filtered_harmonics))/N;     
magX = magX(1:N/2+1);
magX(2:end-1) = 2*magX(2:end-1);

%% Plot fft of the signal with stimulation noise extracted
figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Spectrum with bandpass filtering');
xlim([0, f_max_plot])
grid on;

figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Sectrum with bandpass filtering');
xlim([0, f_max_plot_small])
grid on;

%% Visualization of the ECG filtered with stimulation noise extracted
figure
plot(t, ecg_filtered_harmonics);
title('ECG filtered with bandpass filtering');
xlabel('Time (s)'); 
ylabel('Amplitud');
% xlim([t_min, t_min+20])


%% Derivative (Pan–Tompkins, FIR 5 puntos, ganancia 0.1, retardo 2 muestras)
% H(z) = 0.1(-z^-2 - 2z^-1 + 2z^1 + z^2)
% En tiempo: y[n] = 0.1(-x[n-2] - 2x[n-1] + 2x[n+1] + x[n+2])
% Usamos filtfilt para evitar desfase (corrige el retardo de 2 muestras)

b_der = 0.1 * [-1 -2 0 2 1];  % Coeficientes FIR (causales con delay de 2)
derivative = filtfilt(b_der, 1, ecg_filtered_harmonics);


%%Derivative visualization
figure;
plot(t, derivative);
title('Derivative');
xlabel('Time (s)');
ylabel('Amplitud');


%% Squared signal
derivative_squared = derivative.^2;

figure;
plot(t, derivative_squared);
title('Derivative sqared');
xlabel('Time (s)');
ylabel('Amplitud');
grid on;
ylim([0, 2e-5]);



%% Moving Window Integration (MWI)

% Crear ventana rectangular normalizada
mwi_kernel = ones(window_samples, 1) / window_samples;

% Aplicar convolución para integración móvil
mwi_signal = conv(derivative_squared, mwi_kernel, 'same');

%% Visualización rápida
figure;
plot(t, mwi_signal);
title(['MWI (ventana = ', num2str(window_ms), ' ms)']);
xlabel('Time (s)');
ylabel('Amplitud');
grid on;
ylim([0, 9e-7]);


