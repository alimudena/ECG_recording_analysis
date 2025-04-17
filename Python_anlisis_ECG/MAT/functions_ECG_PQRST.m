function [locs_P, locs_Q, locs_R, locs_S, locs_T, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR] = functions_ECG_PQRST(ECG, th, fs, label)
    locs_R = R_extract(ECG, th, fs);
    [locs_Q, locs_S] = QS_extract(fs, locs_R, ECG);
    [locs_P, locs_T] = PT_extract(fs, locs_R, locs_Q, locs_S, ECG);
    
    
 %   plot_PRQRST(ECG, locs_P, locs_Q, locs_R, locs_S, locs_T, label);
    
    
    PR = PR_interval(locs_Q, locs_P, fs); %Conduccion auriculoventricular
    PS = PS_interval(locs_S, locs_P, fs);
    RS = RS_interval(locs_R, locs_S, fs); 
    RT = RT_interval(locs_R, locs_T, fs); 
    QRS = QRS_duration(locs_S, locs_Q, fs); % Despolarizacion ventricular
    QT = QT_interval(locs_Q, locs_T, fs); %Repolarizacion total
    ST = ST_segment(locs_S, locs_T, fs); %Indicador de isquemia o estres
    RT_voltage = RT_voltage_difference(ECG, locs_R, locs_T);
    RR = R_period_calculation(locs_R, fs);

end


function locs_R = R_extract(ECG, th, fs)
    ECG = double(ECG); 
    % R-Peak Detection (Using Pan-Tompkins or findpeaks)
    [pks, locs] = findpeaks(ECG,'MinPeakHeight', th);
    
    % 2️ Inicializar lista de picos R detectados
    locs_R = [];
    
    % 3️ Recorrer los picos detectados y tomar el primero de cada par R-T
    i = 1;
    while i < length(locs)
        if i < length(locs) && (locs(i+1) - locs(i)) < fs * 0.1  % Máximo 200 ms entre picos contiguos
            % Comprobamos distancia mínima con el último guardado
            if isempty(locs_R) || (locs(i) - locs_R(end)) >= fs * 0.1  % 100 ms
                locs_R = [locs_R; locs(i)];  % Guardamos el primero del par
            end
            i = i + 2;  % Saltamos el segundo pico (T)
        else
            % Comprobamos distancia mínima con el último guardado
            if isempty(locs_R) || (locs(i) - locs_R(end)) >= fs * 0.1  % 100 ms
                locs_R = [locs_R; locs(i)];  % Guardamos el pico aislado
            end
            i = i + 1;
        end
    end

end 


function [locs_Q, locs_S] = QS_extract(fs, locs_R, ECG)
    ECG = double(ECG);
    window = round(0.02 * fs); % 20ms
    
    locs_Q = zeros(size(locs_R));
    locs_S = zeros(size(locs_R));
    
    for i = 1:length(locs_R)
        r = locs_R(i);
        
        % Q: mínimo antes de R
        [~, idx_q] = min(ECG(max(1, r-window):r));
        locs_Q(i) = max(1, r-window) + idx_q - 1;
    
        % S: mínimo después de R
        [~, idx_s] = min(ECG(r:min(length(ECG), r+window)));
        locs_S(i) = r + idx_s - 1;
    end
end

function  [locs_P, locs_T] = PT_extract(fs, locs_R, locs_Q, locs_S, ECG)
    ECG = double(ECG);
    locs_P = zeros(size(locs_R));
    locs_T = zeros(size(locs_R));
    
    for i = 1:length(locs_R)
        q = locs_Q(i);
        s = locs_S(i);
        
        % P: pico antes de Q (en una ventana de 40-60ms)
        win_p = round(0.03*fs); 
        [~, idx_p] = max(ECG(max(1, q - win_p):q));
        locs_P(i) = max(1, q - win_p) + idx_p - 1;
        
        % T: pico después de S (ventana de 60-100ms)
        win_t = round(0.08*fs);
        [~, idx_t] = max(ECG(s:min(length(ECG), s + win_t)));
        locs_T(i) = s + idx_t - 1;
    end
end

function RT_voltage = RT_voltage_difference(ECG, locs_R, locs_T)
    RT_voltage = ECG(locs_R) - ECG(locs_T);
end

function RR = R_period_calculation(locs_R, fs)
    RR = diff(locs_R)/fs;
end

function PR = PR_interval(locs_Q, locs_P, fs) %Conduccion auriculoventricular
    PR = (locs_Q - locs_P) / fs;
end

function PS = PS_interval(locs_S, locs_P, fs) 
    PS = (locs_S - locs_P) / fs;
end

function RS = RS_interval(locs_R, locs_S, fs) 
    RS = (locs_S - locs_R) / fs;

end

function RT = RT_interval(locs_R, locs_T, fs) 
    RT = (locs_T - locs_R) / fs;

end

function QRS = QRS_duration(locs_S, locs_Q, fs) % Despolarizacion ventricular
    QRS = (locs_S - locs_Q) / fs;
end

function QT = QT_interval(locs_Q, locs_T, fs) %Repolarizacion total
    QT = (locs_T - locs_Q) / fs;
end

function ST = ST_segment(locs_S, locs_T, fs) %Indicador de isquemia o estres
    ST = (locs_T - locs_S) / fs;
end
%%
% function plot_PRQRST(ECG, locs_P, locs_Q, locs_R, locs_S, locs_T, label)
%     plot(ECG); hold on;
%     plot(locs_P, ECG(locs_P), 'mo');
%     plot(locs_Q, ECG(locs_Q), 'ko');
%     plot(locs_R, ECG(locs_R), 'ro');
%     plot(locs_S, ECG(locs_S), 'go');
%     plot(locs_T, ECG(locs_T), 'bo');
%     legend('ECG','P','Q','R','S','T');
%     title(label);
% 
% end
