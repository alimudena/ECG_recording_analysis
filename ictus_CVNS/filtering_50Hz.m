function [ecg_filtered_50Hz] = filtering_50Hz(ECG, fs, Q)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    ECG
    fs
    Q
end

arguments (Output)
    ecg_filtered_50Hz
end


    % Filtering of 50 Hz
    % [b,ppm] = iirnotch(50/(fs/2), 50/(fs/2)/Q);
    % ecg_filtered_50Hz = filtfilt(b,ppm, ECG);

    f0 = 50;                  % Frecuencia de la muesca (ruido de línea)
    w0 = f0 / (fs / 2);       % Frecuencia normalizada
    bw = w0 / Q;              % Ancho de banda a -3 dB
    
    % 2. Utilizar el nuevo diseñador de filtros de MATLAB R2025b
    % 'Notch' especifica que es un filtro eliminador de banda estrecho
    [b, a, sv] = designNotchPeakIIR(Response = 'notch', CenterFrequency=w0, Bandwidth= bw);
    
    % peakfilter = dsp.SOSFilter(b, a, ScaleValues = sv);
    % 3. Extraer los coeficientes numéricos del numerador (b) y denominador (a)
    % [b, a] = sos2tf(d.SOSMatrix, d.ScaleValues);
    
    % 4. Aplicar el filtrado de fase cero a la señal de ECG
    ecg_filtered_50Hz = filtfilt(b,a,ECG);
end