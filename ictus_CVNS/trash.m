
clc

experiment = Experiments(1).experiment_number(1);
stim_ON_OFF = experiment.obtained_signals.stim_ON_OFF;

ECG = experiment.obtained_signals.ECG;
t = experiment.obtained_signals.time;
env_smooth = experiment.obtained_signals.env_SMOOTH;
threshold_stim = experiment.obtained_signals.threshold_Stim;

% Detectamos cambios
d = diff(stim_ON_OFF);

% Posiciones donde empieza la estimulación (0 -> 1)
start_idx = find(d == 1) + 1;

% Posiciones donde termina la estimulación (1 -> 0)
end_idx = find(d == -1);

% Caso especial: si empieza ya en 1
if stim_ON_OFF(1) == 1
    start_idx = [1, start_idx];
end

% Caso especial: si termina en 1
if stim_ON_OFF(end) == 1
    end_idx = [end_idx, length(stim_ON_OFF)];
end

%%
figure;

subplot(3,1,1)
plot(t, ECG);
title('ECG original');
xlabel('Tiempo (s)');

subplot(3,1,2)
plot(t, env_smooth); hold on;
yline(threshold_stim, 'R--', 'Umbral');
title('Envolvente del ruido (20 Hz)');
xlabel('Tiempo (s)');

subplot(3,1,3)
plot(t, stim_ON_OFF, 'k');
ylim([-0.2 1.2]);
title('Detección de estimulación (1=sí, 0=no)');
xlabel('Tiempo (s)');

% Dibujar líneas verticales de inicio en verde
for i = 1:length(start_times)
    xline(start_times(i), 'g--', 'LineWidth', 1.5);
end

% Dibujar líneas verticales de fin en rojo
for i = 1:length(end_times)
    xline(end_times(i), 'R--', 'LineWidth', 1.5);
end
%%
plot_with_peaks_VNS(Experiments, rodent, 1);
plot_ECG_and_HRV(Experiments, rodent, 1);



%% PPM cálculo de intervalos

% start_idx y end_idx deben estar ya calculados
% R_T = índices de muestra donde ocurre cada latido
% t = vector de tiempos

nStim = length(start_idx);

BPM_before  = zeros(nStim,1);
BPM_during  = zeros(nStim,1);
BPM_after   = zeros(nStim,1);
BPM_between = zeros(nStim-1,1);
for k = 1:nStim
    
    % Intervalos de muestra (30 s antes, durante, 30 s después)
    t_start = t(start_idx(k));
    t_end   = t(end_idx(k));
    
    % --- 30 SEGUNDOS ANTES ---
    t1 = t_start - 30;
    idx_before = find(t >= t1 & t < t_start);
    % latidos que caen en ese intervalo
    beats_before = R_T(R_T >= idx_before(1) & R_T <= idx_before(end));
    BPM_before(k) = numel(beats_before) / (t_start - t1) * 60;

    % --- DURANTE LA ESTIMULACIÓN ---
    idx_during = start_idx(k) : end_idx(k);
    beats_during = R_T(R_T >= idx_during(1) & R_T <= idx_during(end));
    BPM_during(k) = numel(beats_during) / (t_end - t_start) * 60;

    % --- 30 SEGUNDOS DESPUÉS ---
    t2 = t_end + 30;
    idx_after = find(t > t_end & t <= t2);
    beats_after = R_T(R_T >= idx_after(1) & R_T <= idx_after(end));
    BPM_after(k) = numel(beats_after) / (t2 - t_end) * 60;

end

% --------- Intervalos ENTRE estimulaciones ----------
for k = 1:(nStim - 1)
    
    % tiempos
    t_end_k   = t(end_idx(k));
    t_start_k1 = t(start_idx(k+1));
    
    % punto central entre estímulos
    t_mid = (t_end_k + t_start_k1) / 2;
    
    % 30 segundos centrados en t_mid: 15 antes y 15 después
    tA = t_mid - 15;
    tB = t_mid + 15;
    
    % índices del intervalo
    idx_mid = find(t >= tA & t <= tB);
    
    if ~isempty(idx_mid)
        beats_mid = R(R >= idx_mid(1) & R <= idx_mid(end));
        BPM_between(k) = numel(beats_mid) / 30 * 60;
    else
        BPM_between(k) = NaN;
    end
end

% Mostrar resultados
BPM_before
BPM_during
BPM_after
BPM_between
