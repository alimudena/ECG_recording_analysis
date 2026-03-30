%% =========================================
% DETECCIÓN AUTOMÁTICA DE ESTIMULACIÓN 20 Hz
% Optimizado para ejecución rápida
% fs = 10 kHz
% ==========================================

% Variables de entrada:
%   ECG  -> señal ECG (vector)
%   t    -> vector tiempo
%   fs   -> frecuencia de muestreo (10 kHz)

%% 1. FILTRO FIR RÁPIDO PARA AISLAR 20 Hz
low_cut = 17;
high_cut = 23;

Wp = [low_cut, high_cut] / (fs/2);

% Filtro FIR de orden bajo (rápido + suficiente)
n = 600;   % orden optimizado para velocidad
b = fir1(n, Wp, 'bandpass', kaiser(n+1, 4));

% Filtrado rápido (filtfilt usa FFT)
ECG_filt = filtfilt(b, 1, stim);


%% 2. EXTRAER ENVOLVENTE DEL RUIDO DE ESTIMULACIÓN
env = abs(hilbert(ECG_filt));

% Suavizado rápido usando media móvil
env_smooth = movmean(env, round(0.0005*fs));  % ventana 50 ms


%% 3. UMBRAL AUTOMÁTICO
baseline = median(env_smooth);
noise_std = std(env_smooth);

threshold = baseline + 2* noise_std;


%% 4. DETECCIÓN DE ESTIMULACIÓN (1 = estimulación, 0 = no)
stim = env_smooth > threshold;

figure
plot(stim)
%% 5. MORPHOLOGICAL CLOSING CASERO (une picos irregulares en bloques sólidos)

stim = logical(stim);
stim = stim(:);

% ----- A. RELLENAR HUECOS GRANDES ENTRE PULSOS -----
max_gap_sec = 3;                     % <-- AJÚSTALO (te recomiendo 2s)
max_gap_samples = round(max_gap_sec * fs);

d = diff([0; stim; 0]);
onsets  = find(d == 1);
offsets = find(d == -1) - 1;

for k = 1:length(onsets)-1
    gap = onsets(k+1) - offsets(k) - 1;

    % Si entre dos parches de 1 hay un hueco < 2s, unirlos
    if gap <= max_gap_samples
        stim(offsets(k):onsets(k+1)) = 1;
    end
end

% ----- B. VOLVER A OBTENER LOS BLOQUES RESULTANTES -----
d = diff([0; stim; 0]);
onsets  = find(d == 1);
offsets = find(d == -1) - 1;


% ----- C. QUEDARSE SOLO CON BLOQUES GRANDES -----
min_dur_sec = 10;                   % mínimo: 20s
min_samples = round(min_dur_sec * fs);

stim_clean = zeros(size(stim));

for k = 1:length(onsets)
    dur = offsets(k) - onsets(k);
    if dur >= min_samples
        stim_clean(onsets(k):offsets(k)) = 1;
    end
end

stim_array = stim_clean;      % vector final de estimulación
%%
figure
plot(stim_clean)

%% 7. MOSTRAR RESULTADOS
figure;

subplot(3,1,1)
plot(t, ECG);
title('ECG original');
xlabel('Tiempo (s)');

subplot(3,1,2)
plot(t, env_smooth); hold on;
yline(threshold, 'r--', 'Umbral');
title('Envolvente del ruido (20 Hz)');
xlabel('Tiempo (s)');

subplot(3,1,3)
plot(t, stim_array, 'k');
ylim([-0.2 1.2]);
title('Detección de estimulación (1=sí, 0=no)');
xlabel('Tiempo (s)');