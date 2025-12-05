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
f_max = 550;
f_max_plot = 5000;
f_max_plot_small = 100;
f0 = 20.3293;     % Frequency of the noise
Q = 200;          % Queality facto (higher = thiner)
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
title('Sectrum with no filtering');
xlim([0, f_max_plot])
grid on;

figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Sectrum with no filtering');
xlim([0, f_max_plot_small])
grid on;

%% 2. Filter with central frequency f0
[b,a] = iirnotch(f0/(fs/2), f0/(fs/2)/Q);
ECG_clean = filtfilt(b,a, ECG);

%% fft calculatio with one filter
N = length(ECG_clean);
X = fft(ECG_clean);
magX = abs(X)/N;     
magX = magX(1:N/2+1);
magX(2:end-1) = 2*magX(2:end-1);
%% Plot fft of the signal with f0 signal filtering
figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Sectrum with f0 filtering');
xlim([0, f_max_plot])
grid on;

figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Sectrum with f0 filtering');
xlim([0, f_max_plot_small])
grid on;
%% 3. Filtering at f0 and its harmonics + f_max filtering
ecg_filtered = ECG;  % copy of the signal

% --- Harmonic Notch filtering---
harmonics = f0:f0:f_max;

for f = harmonics
    % Avoid Notch at Nyquist exact (not valid)
    if f >= fs/2
        continue;
    end
    wo = f/(fs/2);        % frecuencia normalizada
    bw = wo/Q;            % ancho de banda normalizado
    [b, a] = iirnotch(wo, bw);
    ecg_filtered = filtfilt(b, a, ecg_filtered);  % filtrado en ambas direcciones
end

% --- Filtro pasa-bajo a 5 kHz ---
lp_cutoff = f_max;          % Hz
[ecg_filtered, filt] = lowpass(ecg_filtered, lp_cutoff, fs, ImpulseResponse="iir", Steepness=0.95);


% --- Filtro notch a 50 Hz
[b,a] = iirnotch(50/(fs/2), 50/(fs/2)/Q);
ecg_filtered = filtfilt(b,a, ecg_filtered);
%% fft calculatio with all harmonitcs filtered
N = length(ecg_filtered);
magX = abs(fft(ecg_filtered))/N;     
magX = magX(1:N/2+1);
magX(2:end-1) = 2*magX(2:end-1);
%% Plot fft of the signal with f0 and harmonics filtering
figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Sectrum with harmonics and f_max filtering');
xlim([0, f_max_plot])
grid on;
%%
figure;
plot(f_figure, magX);
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Sectrum with harmonics and f_max filtering');
xlim([0, f_max_plot_small])
grid on;

%% Visualization of the ECG filtered with f0 and harmonics
figure
plot(t, ecg_filtered);
title('ECG filtered with f0 and harmonics');
xlabel('Time (s)'); 
ylabel('Amplitud');
xlim([t_min, t_min+20])

%% Visualization of the ECG signal without and with filtering
figure;
subplot(3,1,1);
plot(t, ECG);
title('Original ECG with stimulation');
xlabel('Time (s)'); 
ylabel('Amplitud');
% xlim([t_min, t_min+20])

subplot(3,1,2);
plot(t, ECG_clean);
title('Original ECG with stimulation f0 filtering');
xlabel('Time (s)'); 
ylabel('Amplitud');
% xlim([t_min, t_min+20])

subplot(3,1,3);
plot(t, ecg_filtered);
title('Original ECG with stimulation harmonics of f0 and f_max filtering');
xlabel('Time (s)'); 
ylabel('Amplitud');
% xlim([t_min, t_min+20])

%% Visualization of the ECG filtered for selecting the amplitude 
figure
plot(t, ecg_filtered);
title('ECG for threshold selection');
xlabel('Time (s)'); 
ylabel('Amplitud');
xlim([t_min, t_min+20])

%%
figure
plot(t, ecg_filtered);
title('ECG for threshold selection');
xlabel('Time (s)'); 
ylabel('Amplitud');


%% Extraction of the R peaks from the ECG pulses
[A, A_T]  = findpeaks(ecg_filtered, 'MinPeakHeight', th_ECG_inf, 'MinPeakDistance', peak_distance);

%% PPM calculation
data_T = A_T;
data = ECG(A_T);

delta_t_muestra = delta_t_segundos*fs;
ventana_muestra = ventana_segundos*fs;

steps = round(length(ECG)/delta_t_muestra);

peaks_in_window = zeros(1, steps);
mid_window = zeros(1, steps);

for i=1:steps
    muestra_init = delta_t_muestra*(i-1);
    muestra_end = ventana_muestra + delta_t_muestra*(i-1);
    mid_window(i) = ventana_segundos + delta_t_segundos*(i-1);
    peaks_in_window(i) = sum(((data_T<muestra_end) & (data_T>muestra_init)))*(60/ventana_segundos);
end
%% Visualization of the stimulation, the ECG filtered and not filtered, the peaks R and the ppm calculation
figure;
hold on
plot(t, stim*50)
plot(mid_window,peaks_in_window)
title(file, 'Interpreter', 'none')
grid on

figure;
hold on
plot(t, ECG*50)
plot(t, ecg_filtered*50, 'r')
plot(mid_window,peaks_in_window)
plot(t(A_T), ecg_filtered(A_T)*50, '*');
title(file, 'Interpreter', 'none')
grid on
grid minor

%% RR or Heart Rate Variability study
%N-N interval
RR = diff(A_T)/fs;

figure;
hold on
plot(t, ECG/5)
plot(t(A_T), ECG(A_T), '*');
plot(t(A_T(1: end-1)), RR, 'b-o');
title('Intervalos RR (N-N)');
xlabel('Latido');
ylabel('Tiempo (s)');
ylim([-0.4, 0.8])
hold off
grid on;


%%Ectopic filtered and outliers

RR_filtered = RR(abs(diff(RR)./RR(1:end-1)) < 0.2);
RR_filtered = RR_filtered(abs(RR_filtered - mean(RR_filtered)) < 3*std(RR_filtered));


%% SDNN and RMSSD

SDNN = std(RR_filtered);
RMSSD = sqrt(mean(diff(RR_filtered).^2));

%% Interpolación y PSD


t = cumsum(RR_filtered);
tq = 0:0.01:t(end); % 100 Hz interpolación
RR_interp = interp1(t, RR_filtered, tq, 'pchip');
[pxx,f] = pwelch(RR_interp,[],[],[],100);
TP = bandpower(pxx,fs,[0.16 3]);
LF = bandpower(pxx,fs,[0.16 0.6]);
HF = bandpower(pxx,fs,[0.6 3]);

figure;
plot(f, pxx);
title('Densidad espectral de potencia (HRV)');
xlabel('Frecuencia (Hz)');
ylabel('Potencia');
xlim([0 3]); % Rango típico para HRV en roedores
grid on;
hold on;
xline(0.16, '--r', 'LF inicio');
xline(0.6, '--r', 'LF fin / HF inicio');



figure;
plot(mid_window, peaks_in_window, 'LineWidth', 1.5);
title('Frecuencia cardíaca en el tiempo (PPM)');
xlabel('Tiempo (s)');
ylabel('Latidos por minuto');
grid on;



%% detrend
t = (0:N-1)/fs;

figure
a = detrend(peaks_in_window);
hold on;
plot(mid_window,peaks_in_window-mean(peaks_in_window));
plot(t, ecg_filtered*50);
plot(mid_window, a);
legend("ppm", "detrended", "ecg")
ylim([-100, 100])

hold off
