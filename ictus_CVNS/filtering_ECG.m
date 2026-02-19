function [ecg_filtered_harmonics] = filtering_ECG(ECG, fs, Q, f_low_pass, f_high_pass, f0, f_max)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    ECG
    fs
    Q
    f_low_pass
    f_high_pass
    f0
    f_max
end

arguments (Output)
    ecg_filtered_harmonics
end

    [ecg_filtered_50Hz] = filtering_50Hz(ECG, fs, Q);
    [ecg_filtered_low_pass, ~] = lowpass(ecg_filtered_50Hz, f_low_pass, fs, ImpulseResponse="iir", Steepness=0.95);

    Wn = f_high_pass / (fs/2);   
    [b_hpf, ppm_hpf] = butter(4, Wn, 'high');
    
    ecg_filtered_band_pass = filtfilt(b_hpf, ppm_hpf, ecg_filtered_low_pass);

    ecg_filtered_harmonics = stim_and_harmonics_filtering(f0, fs, f_max, Q, ecg_filtered_band_pass);
end