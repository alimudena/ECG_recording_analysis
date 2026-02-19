function [ecg_filtered_harmonics] = stim_and_harmonics_filtering(f0, fs, f_max, Q, ecg_filtered_band_pass)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    f0
    fs
    f_max
    Q
    ecg_filtered_band_pass
end

arguments (Output)
    ecg_filtered_harmonics
end

    harmonics = f0:f0:f_max;
    ecg_filtered_harmonics = ecg_filtered_band_pass;
    for f = harmonics
        % Avoid Notch at Nyquist exact (not valid)
        if f >= fs/2
            continue;
        end
        wo = f/(fs/2);        % frecuencia normalizada
        bw = wo/Q;            % ancho de banda normalizado
        [b, ppm] = iirnotch(wo, bw);
        ecg_filtered_harmonics = filtfilt(b, ppm, ecg_filtered_harmonics);  % filtrado en ambas direcciones
    end
end