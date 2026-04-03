function [stim_array, env_smooth, threshold_stim, start_idx, end_idx] = extract_stim_times(low_cut, high_cut, window_smooth, n, stim, fs)

    
    Wp = [low_cut, high_cut] / (fs/2);
    
    % Filtro FIR de orden bajo (rápido + suficiente)
    b = fir1(n, Wp, 'bandpass', kaiser(n+1, 4));
    
    % Filtrado rápido (filtfilt usa FFT)
    stim_filt = filtfilt(b, 1, stim);


    env = abs(hilbert(stim_filt));

    % Suavizado rápido usando media móvil
    env_smooth = movmean(env, round(window_smooth*fs));  % ventana 50 ms

    baseline = median(env_smooth);
    noise_std = std(env_smooth);
    
    threshold_stim = baseline + 2* noise_std;

    stim_on = env_smooth > threshold_stim;

    figure
    plot(stim_on)

    stim_on = logical(stim_on);
    stim_on = stim_on(:);
    
    % ----- A. RELLENAR HUECOS GRANDES ENTRE PULSOS -----
    max_gap_sec = 3;                     % <-- AJÚSTALO (te recomiendo 2s)
    max_gap_samples = round(max_gap_sec * fs);
    
    d = diff([0; stim_on; 0]);
    onsets  = find(d == 1);
    offsets = find(d == -1) - 1;
    
    for k = 1:length(onsets)-1
        gap = onsets(k+1) - offsets(k) - 1;
    
        % Si entre dos parches de 1 hay un hueco < 2s, unirlos
        if gap <= max_gap_samples
            stim_on(offsets(k):onsets(k+1)) = 1;
        end
    end
    
    % ----- B. VOLVER A OBTENER LOS BLOQUES RESULTANTES -----
    d = diff([0; stim_on; 0]);
    onsets  = find(d == 1);
    offsets = find(d == -1) - 1;
    
    
    % ----- C. QUEDARSE SOLO CON BLOQUES GRANDES -----
    min_dur_sec = 10;                   % mínimo: 20s
    min_samples = round(min_dur_sec * fs);
    
    stim_clean = zeros(size(stim_on));
    
    for k = 1:length(onsets)
        dur = offsets(k) - onsets(k);
        if dur >= min_samples
            stim_clean(onsets(k):offsets(k)) = 1;
        end
    end
    
    stim_array = stim_clean;      % vector final de estimulación

    figure
    plot(stim_clean)


    % Detectamos cambios
    d = diff(stim_clean);
    
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



end