function process_file(folder, file, threshold, save_option)
    file_name = append(folder, "/", file);
    data = load(file_name);
    [ECG, stim_reference, d3, fs, time] = extract_data(data);
    if save_option == 1
        %%Signal filtered only in stim times
        ecg_signal = double(ECG(:));
        over = stim_reference>1;
        senal = over;
        
        tramo = 20000;
        
        N = length(senal);
        senal_filtrada = over; % Copia de la señal original
        
        for i = 1:tramo:N
            fin_tramo = min(i + tramo - 1, N); % Asegurar que no exceda el tamaño de la señal
            segmento = senal(i:fin_tramo);
        
            % Determinar el valor predominante en el tramo
            %    if sum(segmento) >= length(segmento) / 2
            if sum(segmento) >= 1
                valor_predominante = 1;
            else
                valor_predominante = 0;
            end
        
            % Asignar el valor predominante a todo el tramo
            senal_filtrada(i:fin_tramo) = valor_predominante;
        end
        
        ecg_signal = ecg_signal.*~senal_filtrada;
        
        % 1. Preprocessing - Filtering the Signal
        % High-pass filter to remove baseline wander (0.5 Hz)
        hpFilt = designfilt('highpassiir','FilterOrder',4, ...
            'HalfPowerFrequency',0.5,'SampleRate',fs);
        ecg_hp = filtfilt(hpFilt, ecg_signal);
        
        
        
        % Low-pass filter to remove high-frequency noise (250 Hz)
        lpFilt = designfilt('lowpassiir','FilterOrder',4, ...
            'HalfPowerFrequency',250,'SampleRate',fs);
        ecg_filt = filtfilt(lpFilt, ecg_hp);
        
        
        % 2. R-Peak Detection (Using Pan-Tompkins or findpeaks)
        % [~, R_locs] = findpeaks(ecg_filt, 'MinPeakHeight', threshold, ...
        %     'MinPeakDistance', fs*0.05); % 50ms min distance between beats
        [pks, locs] = findpeaks(ecg_filt,'MinPeakHeight', threshold);
        
        % 2️ Inicializar lista de picos R detectados
        R_locs = [];
        
        % 3️ Recorrer los picos detectados y tomar el primero de cada par R-T
        i = 1;
        while i < length(locs)
            if i < length(locs) && (locs(i+1) - locs(i)) < fs * 0.2  % Máximo 200ms entre picos contiguos
                R_locs = [R_locs; locs(i)];  % Seleccionamos siempre el primero del par
                i = i + 2;  % Saltamos al siguiente ciclo (ignoramos el pico T)
            else
                R_locs = [R_locs; locs(i)];
                i = i + 1;
            end
        end
        
        %%3. Identify P and Q Waves
        clc
        P_locs = []; % Store P-wave locations
        Q_locs = []; % Store Q-wave locations
        P_Q_diff = []; % Store P-Q amplitude differences
        P_Q_time = []; % Store P-Q time differences
        Q_R_time = []; % Store Q-R time differences
        P_R_time = []; % Store P-R time differences
        P_P_time = [];
        R_prev = 0;
        
        for i = 1:length(R_locs)
            % Define search windows relative to R-peak
            final = R_locs(i) - round(0.02*fs);
            if final< 0
                final = 1;
        
            end
        
            search_window_P = max(R_locs(i) - round(0.1*fs), 1) : final;
            search_window_Q = final : R_locs(i) - round(0.005*fs);
        
            % Find P-wave (Max peak in window)
            [P_val, P_idx] = max(ecg_filt(search_window_P));
            P_locs(i) = search_window_P(1) + P_idx - 1;
        
            % Find Q-wave (Min peak in window)
            [Q_val, Q_idx] = min(ecg_filt(search_window_Q));
            Q_locs(i) = search_window_Q(1) + Q_idx - 1;
        
            % Compute P-Q amplitude difference
            P_Q_diff(i) = P_val - Q_val;
        
            % Compute time differences
            T_P = time(P_locs(i));
            T_Q = time(Q_locs(i));
            T_R = time(R_locs(i));
        
            P_Q_time(i) = T_Q - T_P; % P-Q interval
            Q_R_time(i) = T_R - T_Q; % Q-R interval
            P_R_time(i) = T_R - T_P; % P-R interval
            R_R_time(i) = T_R - R_prev;
        
            R_prev = T_R;
         
        end
    
        save(file, "P_P_time", "P_R_time", "P_Q_time", "Q_R_time", "R_R_time", "P_locs", "Q_locs", "R_locs", "ecg_signal", "stim_reference", "ecg_filt", "time", "ECG" )
   
    else
        save(file, "stim_reference", "time", "ECG" )
    end
end