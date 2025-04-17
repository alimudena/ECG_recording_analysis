function [ECG, stim_reference, d3, fs, time] = extract_data(data)
    signal = data.signal;
    ECG = signal(:,1);
    stim_reference = signal(:,2);
    d3 = signal(:,3);
    fs = data.sampling_rate;
    time = (0:length(ECG)-1) * 1/fs;

end

