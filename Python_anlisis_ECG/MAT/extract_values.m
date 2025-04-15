
% close all
clc
file_name = 'estimulación-ratón 2.mat';
threshold = 0.4;

data = load(file_name);
[ECG, stim_reference, d3, fs, time] = extract_data(data);
clc
%%Detección de picos R en la seal ECG sin filtrar
ecg_signal = ECG(:); % Ajusta el nombre según tu archivo
[peaks_raw, locs_raw] = findpeaks(ecg_signal, 'MinPeakHeight', threshold); % Evitar detección múltiple en un mismo ciclo

segment_duration = 5;
[time_intervals, bpm_values_raw] = BPM_calculation(segment_duration, fs, ecg_signal, locs_raw);
bpm2 = bpm_values_raw;
tint2 = time_intervals;



figure
plot(time, ecg_signal);
hold on
plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
hold off
xlabel('Tiempo');
ylabel('Amplitud');
xlim([1425 1426])
title('Check ECG is correctly plotted');
grid on;
%%
figure;
plot(bpm0)
hold on
plot(bpm1)
plot(bpm2)
title('BPM')
legend('control', 'R1', 'R2')
hold off

%% Graficar la seal ECG con picos detectados
% figure;
% plot(time, ecg_signal);
% hold on;
% plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
% xlabel('Tiempo');
% ylabel('Amplitud');
% title('Seal ECG con detección de picos R');
% legend('ECG', 'Picos R');
% hold off;
%%
% figure
% plot(time, stim_reference)
% title('Stimulation signal reference');


%% Mostrar BPM en intervalos de 15s
% figure;
% plot(time_intervals, bpm_values_raw, '-');
% xlabel('Tiempo (s)');
% ylabel('Pulsaciones por Minuto (BPM)');
% title('Frecuencia Cardiaca en intervalos de 15 segundos');
% ylim([0, 800])
% grid on;
% hold off;

%%
% figure
% plot(time, ecg_signal/max(ecg_signal));
% hold on
% plot(time(locs_raw), ecg_signal(locs_raw)/max(ecg_signal), 'ro'); % Marcar picos R en rojo
% plot(time, stim_reference/max(stim_reference))
% plot(time_intervals, bpm_values_raw/max(bpm_values_raw), '-', Color='y');
% 
% hold off

%%
figure

% Primer subplot (arriba)
ax1 = subplot(3,1,1);
plot(time, ecg_signal);
hold on
plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
hold off
xlabel('Tiempo');
ylabel('Amplitud');
title('Seal ECG con detección de picos R');
grid on;

% Segundo subplot (medio)
ax2 = subplot(3,1,2);
plot(time, stim_reference)
title('Stimulation signal reference');
xlabel('Tiempo');
grid on;

% Tercer subplot (abajo)
ax3 = subplot(3,1,3);
plot(time_intervals, bpm_values_raw, '-');
ylim([300, 600])
xlim([500, 3500])
xlabel('Tiempo (s)');
ylabel('Pulsaciones por Minuto (BPM)');
title('Frecuencia Cardiaca en intervalos de 5 segundos');
grid on;
linkaxes([ax1, ax2, ax3], 'x');


%%
% figure
% time_lim = [1000, 2000];
% % Primer subplot (arriba)
% ax1 = subplot(3,1,1);
% plot(time, ecg_signal);
% hold on
% plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
% hold off
% xlabel('Tiempo');
% ylabel('Amplitud');
% xlim(time_lim);
% title('Seal ECG con detección de picos R');
% grid on;
% 
% % Segundo subplot (medio)
% ax2 = subplot(3,1,2);
% plot(time, stim_reference)
% title('Stimulation signal reference');
% xlabel('Tiempo');
% xlim(time_lim);
% grid on;
% 
% % Tercer subplot (abajo)
% ax3 = subplot(3,1,3);
% plot(time_intervals, bpm_values_raw, '-');
% ylim([200, 800])
% xlim(time_lim);
% xlabel('Tiempo (s)');
% ylabel('Pulsaciones por Minuto (BPM)');
% title('Frecuencia Cardiaca en intervalos de 5 segundos');
% grid on;
% linkaxes([ax1, ax2, ax3], 'x');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clc
file_name = 'estimulación-ratón 1.mat';
threshold = 0.4;

data = load(file_name);
[ECG, stim_reference, d3, fs, time] = extract_data(data);
clc

%%Detección de picos R en la seal ECG sin filtrar
ecg_signal = -ECG(:); % Ajusta el nombre según tu archivo
[peaks_raw, locs_raw] = findpeaks(ecg_signal, 'MinPeakHeight', threshold); % Evitar detección múltiple en un mismo ciclo

[time_intervals, bpm_values_raw] = BPM_calculation(segment_duration, fs, ecg_signal, locs_raw);
bpm2 = bpm_values_raw;
tint2 = time_intervals;

%% Graficar la seal ECG con picos detectados
% figure;
% plot(time, ecg_signal);
% hold on;
% plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
% xlabel('Tiempo');
% ylabel('Amplitud');
% title('Seal ECG con detección de picos R');
% legend('ECG', 'Picos R');
% hold off;
% %%
% figure
% plot(time, stim_reference)
% title('Stimulation signal reference');
% 
% 
% %% Mostrar BPM en intervalos de 15s
% figure;
% plot(time_intervals, bpm_values_raw, '-');
% xlabel('Tiempo (s)');
% ylabel('Pulsaciones por Minuto (BPM)');
% title('Frecuencia Cardiaca en intervalos de 15 segundos');
% ylim([0, 800])
% grid on;
% hold off;

%%
% figure
% plot(time, ecg_signal/max(ecg_signal));
% hold on
% plot(time(locs_raw), ecg_signal(locs_raw)/max(ecg_signal), 'ro'); % Marcar picos R en rojo
% plot(time, stim_reference/max(stim_reference))
% plot(time_intervals, bpm_values_raw/max(bpm_values_raw), '-', Color='y');
% 
% hold off

%%
figure

% Primer subplot (arriba)
ax1 = subplot(3,1,1);
plot(time, ecg_signal);
hold on
plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
hold off
xlabel('Tiempo');
ylabel('Amplitud');
ylim([-1, 1]);
title('Seal ECG con detección de picos R');
grid on;

% Segundo subplot (medio)
ax2 = subplot(3,1,2);
plot(time, stim_reference)
title('Stimulation signal reference');
xlabel('Tiempo');
grid on;

% Tercer subplot (abajo)
ax3 = subplot(3,1,3);
plot(time_intervals, bpm_values_raw, '-');
ylim([300, 800])
xlabel('Tiempo (s)');
ylabel('Pulsaciones por Minuto (BPM)');
title('Frecuencia Cardiaca en intervalos de 5 segundos');
grid on;
linkaxes([ax1, ax2, ax3], 'x');


%%
% figure
% time_lim = [1920, 1970];
% % Primer subplot (arriba)
% ax1 = subplot(3,1,1);
% plot(time, ecg_signal);
% hold on
% plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
% hold off
% xlabel('Tiempo');
% ylabel('Amplitud');
% xlim(time_lim);
% title('Seal ECG con detección de picos R');
% grid on;
% 
% % Segundo subplot (medio)
% ax2 = subplot(3,1,2);
% plot(time, stim_reference)
% title('Stimulation signal reference');
% xlabel('Tiempo');
% xlim(time_lim);
% grid on;
% 
% % Tercer subplot (abajo)
% ax3 = subplot(3,1,3);
% plot(time_intervals, bpm_values_raw, '-');
% ylim([200, 800])
% xlim(time_lim);
% xlabel('Tiempo (s)');
% ylabel('Pulsaciones por Minuto (BPM)');
% title('Frecuencia Cardiaca en intervalos de 5 segundos');
% grid on;
% linkaxes([ax1, ax2, ax3], 'x');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Detección de picos R en la seal ECG sin filtrar
init = 20000000;
fin = 22500000;

time = time(init: fin);
stim_reference = stim_reference(init: fin);
ecg_signal = -ECG(init: fin); % Ajusta el nombre según tu archivo
%%
[peaks_raw, locs_raw] = findpeaks(ecg_signal, 'MinPeakHeight', threshold); % Evitar detección múltiple en un mismo ciclo

[time_intervals, bpm_values_raw] = BPM_calculation(segment_duration, fs, ecg_signal, locs_raw);


figure
% Primer subplot (arriba)
ax1 = subplot(2,1,1);
plot(time, ecg_signal);
hold on
plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
hold off
xlabel('Tiempo');
ylabel('Amplitud');
title('Seal ECG con detección de picos R');
xlim([min(time), max(time)])
grid on;

% Tercer subplot (abajo)
ax3 = subplot(2,1,2);
plot(bpm_values_raw, '-');
ylim([300, 800])
xlabel('Tiempo (s)');
ylabel('Pulsaciones por Minuto (BPM)');
title('Frecuencia Cardiaca en intervalos de 5 segundos');
grid on;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clc
file_name = 'estimulación-ratón 2.mat';
threshold = 0.4;

data = load(file_name);
[ECG, stim_reference, d3, fs, time] = extract_data(data);
clc

%%Detección de picos R en la seal ECG sin filtrar
ecg_signal = -ECG(:); % Ajusta el nombre según tu archivo
[peaks_raw, locs_raw] = findpeaks(ecg_signal, 'MinPeakHeight', threshold); % Evitar detección múltiple en un mismo ciclo

[time_intervals, bpm_values_raw] = BPM_calculation(segment_duration, fs, ecg_signal, locs_raw);
bpm3 = bpm_values_raw;
tint3 = time_intervals;

%% Graficar la seal ECG con picos detectados
% figure;
% plot(time, ecg_signal);
% hold on;
% plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
% xlabel('Tiempo');
% ylabel('Amplitud');
% title('Seal ECG con detección de picos R');
% legend('ECG', 'Picos R');
% hold off;
% %%
% figure
% plot(time, stim_reference)
% title('Stimulation signal reference');
% 
% 
% %% Mostrar BPM en intervalos de 15s
% figure;
% plot(time_intervals, bpm_values_raw, '-');
% xlabel('Tiempo (s)');
% ylabel('Pulsaciones por Minuto (BPM)');
% title('Frecuencia Cardiaca en intervalos de 15 segundos');
% ylim([0, 800])
% grid on;
% hold off;

%%
% figure
% plot(time, ecg_signal/max(ecg_signal));
% hold on
% plot(time(locs_raw), ecg_signal(locs_raw)/max(ecg_signal), 'ro'); % Marcar picos R en rojo
% plot(time, stim_reference/max(stim_reference))
% plot(time_intervals, bpm_values_raw/max(bpm_values_raw), '-', Color='y');
% 
% hold off

%%
figure

% Primer subplot (arriba)
ax1 = subplot(3,1,1);
plot(time, ecg_signal);
hold on
plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
hold off
xlabel('Tiempo');
ylabel('Amplitud');
ylim([-1, 1]);
title('Seal ECG con detección de picos R');
grid on;

% Segundo subplot (medio)
ax2 = subplot(3,1,2);
plot(time, stim_reference)
title('Stimulation signal reference');
xlabel('Tiempo');
grid on;

% Tercer subplot (abajo)
ax3 = subplot(3,1,3);
plot(time_intervals, bpm_values_raw, '-');
ylim([300, 800])
xlabel('Tiempo (s)');
ylabel('Pulsaciones por Minuto (BPM)');
title('Frecuencia Cardiaca en intervalos de 5 segundos');
grid on;
linkaxes([ax1, ax2, ax3], 'x');


%%
% figure
% time_lim = [1920, 1970];
% % Primer subplot (arriba)
% ax1 = subplot(3,1,1);
% plot(time, ecg_signal);
% hold on
% plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
% hold off
% xlabel('Tiempo');
% ylabel('Amplitud');
% xlim(time_lim);
% title('Seal ECG con detección de picos R');
% grid on;
% 
% % Segundo subplot (medio)
% ax2 = subplot(3,1,2);
% plot(time, stim_reference)
% title('Stimulation signal reference');
% xlabel('Tiempo');
% xlim(time_lim);
% grid on;
% 
% % Tercer subplot (abajo)
% ax3 = subplot(3,1,3);
% plot(time_intervals, bpm_values_raw, '-');
% ylim([200, 800])
% xlim(time_lim);
% xlabel('Tiempo (s)');
% ylabel('Pulsaciones por Minuto (BPM)');
% title('Frecuencia Cardiaca en intervalos de 5 segundos');
% grid on;
% linkaxes([ax1, ax2, ax3], 'x');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Detección de picos R en la seal ECG sin filtrar
init = 20000000;
fin = 22500000;

time = time(init: fin);
stim_reference = stim_reference(init: fin);
ecg_signal = -ECG(init: fin); % Ajusta el nombre según tu archivo

[peaks_raw, locs_raw] = findpeaks(ecg_signal, 'MinPeakHeight', threshold); % Evitar detección múltiple en un mismo ciclo

[time_intervals, bpm_values_raw] = BPM_calculation(segment_duration, fs, ecg_signal, locs_raw);


figure
% Primer subplot (arriba)
ax1 = subplot(2,1,1);
plot(time, ecg_signal);
hold on
plot(time(locs_raw), ecg_signal(locs_raw), 'ro'); % Marcar picos R en rojo
hold off
xlabel('Tiempo');
ylabel('Amplitud');
title('Seal ECG con detección de picos R');
xlim([min(time), max(time)])
grid on;

% Tercer subplot (abajo)
ax3 = subplot(2,1,2);
plot(bpm_values_raw, '-');
ylim([300, 800])
xlabel('Tiempo (s)');
ylabel('Pulsaciones por Minuto (BPM)');
title('Frecuencia Cardiaca en intervalos de 5 segundos');
grid on;
%

figure
plot(bpm1)
hold on
plot(bpm2)
plot(bpm3)
ylim([0, 800])
legend('ref', 'R1', 'R2')
hold off

