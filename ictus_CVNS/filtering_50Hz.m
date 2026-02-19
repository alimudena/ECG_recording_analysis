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
    [b,ppm] = iirnotch(50/(fs/2), 50/(fs/2)/Q);
    ecg_filtered_50Hz = filtfilt(b,ppm, ECG);
end