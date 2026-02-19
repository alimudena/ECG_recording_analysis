function [mwi_signal] = PanHopkings(ecg_filtered_harmonics, fs, window_samples)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    ecg_filtered_harmonics
    fs
    window_samples
end

arguments (Output)
    mwi_signal
end

b_der = 0.1 * [-1 -2 0 2 1];  % Coeficientes FIR (causales con delay de 2)
derivative = filtfilt(b_der, 1, ecg_filtered_harmonics) * fs;

%%Squared signal
derivative_squared = derivative.^2;
%%Moving Window Integration (MWI)

% Crear ventana rectangular normalizada
mwi_kernel = ones(window_samples, 1) / window_samples;

% Aplicar convolución para integración móvil
mwi_signal = conv(derivative_squared, mwi_kernel, 'same');

end