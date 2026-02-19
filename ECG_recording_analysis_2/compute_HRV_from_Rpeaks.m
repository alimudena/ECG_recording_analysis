function results = compute_HRV_from_Rpeaks(R_peaks, fs)
% compute_HRV_from_Rpeaks
% --------------------------------------------------------------
% INPUT:
%   R_peaks : vector con posiciones de los picos R (en muestras)
%   fs      : frecuencia de muestreo del ECG
%
% OUTPUT (struct):
%   results.NN              -> intervalos NN (ms)
%   results.SDNN            -> desviación estándar NN
%   results.SDANN           -> SDANN usando ventanas de 5 min
%   results.SDNN_index      -> promedio de SDNN en ventanas de 5 min
%   results.RMSSD           -> RMSSD
%   results.NN50            -> NN50
%   results.pNN50           -> pNN50
%   results.TriangularIndex -> HRV Triangular Index
%   results.LF, HF, LF_HF   -> componentes espectrales
%
% --------------------------------------------------------------

%%1. Calcular NN intervals (en ms)
RR_intervals = diff(R_peaks) / fs;     % en segundos
NN = RR_intervals * 1000;              % convertir a ms

results.NN = NN;

%%2. SDNN (variabilidad global)
results.SDNN = std(NN);

%%3. SDANN y SDNN-index (con ventanas de 5 min)
window_min = 5;
window_samples = window_min * 60 * fs;

%Crear las ventanas de 5 minutos sobre los picos R
num_windows = floor(R_peaks(end) / window_samples);

meanNN_win = [];

for w = 1:num_windows
    idx_start = (w-1) * window_samples;
    idx_end   = w * window_samples;

    idx = find(R_peaks > idx_start & R_peaks <= idx_end);
    if numel(idx) > 2
        NN_w = diff(R_peaks(idx)) / fs * 1000;
        meanNN_win = [meanNN_win; mean(NN_w)];
    end
end

if length(meanNN_win) > 1
    results.SDANN = std(meanNN_win);
else
    results.SDANN = NaN;
end

%SDNN-index: media de SDNN en cada ventana
SDNN_windows = [];
for w = 1:num_windows
    idx_start = (w-1) * window_samples;
    idx_end   = w * window_samples;

    idx = find(R_peaks > idx_start & R_peaks <= idx_end);
    if numel(idx) > 2
        NN_w = diff(R_peaks(idx)) / fs * 1000;
        SDNN_windows = [SDNN_windows; std(NN_w)];
    end
end

if ~isempty(SDNN_windows)
    results.SDNN_index = mean(SDNN_windows);
else
    results.SDNN_index = NaN;
end

%%4. RMSSD
diffNN = diff(NN);
results.RMSSD = sqrt(mean(diffNN.^2));

%%5. NN50 y pNN50
results.NN50 = sum(abs(diffNN) > 50);
results.pNN50 = (results.NN50 / length(diffNN)) * 100;

%%6. HRV Triangular Index
[counts, edges] = histcounts(NN, 'BinWidth', 7.8125); % estándar HRV
N_total = length(NN);
results.TriangularIndex = N_total / max(counts);

%%7. ESPECTRO (LF / HF) usando Welch
% Interpolar series NN a 4 Hz (recomendado Task Force)
tRR = cumsum(NN)/1000;
fs_interp = 4; 
t_interp = 0 : 1/fs_interp : tRR(end);
NN_interp = interp1(tRR, NN, t_interp, 'spline');

% PSD Welch
[pxx, f] = pwelch(NN_interp - mean(NN_interp), ...
                  hamming(256), 128, 1024, fs_interp);

% Bandas HRV
LF_band = [0.04 0.15];
HF_band = [0.15 0.40];

results.LF = trapz(f(f>=LF_band(1)&f<=LF_band(2)), ...
                   pxx(f>=LF_band(1)&f<=LF_band(2)));

results.HF = trapz(f(f>=HF_band(1)&f<=HF_band(2)), ...
                   pxx(f>=HF_band(1)&f<=HF_band(2)));

results.LF_HF = results.LF / results.HF;

end