function [t, stim, ECG, fs] = parameter_extraction(folder, file)
    % Cargar el archivo
    datos = load(folder+"/"+file+".mat");
    %%Extract the ECG signal, the stimulation signal and the sampling frequency used.
    signal = datos.signal;
    fs = datos.sampling_rate;
    ECG = double(signal(:, 1));
    stim = signal(:, 2);    
    N = length(ECG);
    %%Calculate the timing array and clear all the unnecesary data
    t = (0:N-1)/fs;
    clear signal;
    clear datos;
    close all;
    clc;
end