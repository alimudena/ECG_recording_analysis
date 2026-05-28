function [mnn, sdnn, rmssd] = calculate_hrv_parameters(R_peaks_analyzed, fs)
    % RR_intervals = diff(R_peaks_analyzed);
    % mnn = mean(RR_intervals)*(1000/fs);
    % sdnn = std(RR_intervals);
    % diff_RR = diff(RR_intervals);
    % rmssd = sqrt(mean(diff_RR.^2));



    % RR en segundos
    RR_intervals = diff(R_peaks_analyzed) / fs;

    % RR en milisegundos
    RR_ms = RR_intervals * 1000;

    % HRV parameters
    mnn   = mean(RR_ms);
    sdnn  = std(RR_ms);

    diff_RR = diff(RR_ms);
    rmssd = sqrt(mean(diff_RR.^2));

end
