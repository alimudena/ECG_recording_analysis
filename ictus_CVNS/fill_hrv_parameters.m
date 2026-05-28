function [all_before_mnn, all_during_mnn, all_after_mnn, ...
    all_before_sdnn, all_during_sdnn, all_after_sdnn,...
    all_before_rmssd, all_during_rmssd, all_after_rmssd,...
    all_before_LF, all_during_LF, all_after_LF,...
    all_before_HF, all_during_HF, all_after_HF,...
    all_before_TP, all_during_TP, all_after_TP,...
    all_before_LF_HF_ratio, all_during_LF_HF_ratio, all_after_LF_HF_ratio...
    ] = fill_hrv_parameters(start_idx, end_idx, fs, R_T, studied_intervals)
    
    %MNN
    all_before_mnn = zeros(1, length(start_idx));
    all_during_mnn = zeros(1, length(start_idx));
    all_after_mnn = zeros(1, length(start_idx));
    
    %SDNN
    all_before_sdnn = zeros(1, length(start_idx));
    all_during_sdnn = zeros(1, length(start_idx));
    all_after_sdnn = zeros(1, length(start_idx));
    
    %RMSSD
    all_before_rmssd = zeros(1, length(start_idx));
    all_during_rmssd = zeros(1, length(start_idx));
    all_after_rmssd = zeros(1, length(start_idx));

    %LF
    all_before_LF = zeros(1, length(start_idx));
    all_during_LF = zeros(1, length(start_idx));
    all_after_LF = zeros(1, length(start_idx));


    %HF
    all_before_HF = zeros(1, length(start_idx));
    all_during_HF = zeros(1, length(start_idx));
    all_after_HF = zeros(1, length(start_idx));

    %LF/HF
    all_before_LF_HF_ratio = zeros(1, length(start_idx));
    all_during_LF_HF_ratio = zeros(1, length(start_idx));
    all_after_LF_HF_ratio = zeros(1, length(start_idx));

    %HF
    all_before_TP = zeros(1, length(start_idx));
    all_during_TP = zeros(1, length(start_idx));
    all_after_TP = zeros(1, length(start_idx));


    %f of HF/LF
    all_f_before = zeros(1, length(start_idx));
    all_f_during = zeros(1, length(start_idx));
    all_f_after = zeros(1, length(start_idx));

    %pxx
    all_pxx_before = zeros(1, length(start_idx));
    all_pxx_during = zeros(1, length(start_idx));
    all_pxx_after = zeros(1, length(start_idx));

    
    for studied_time = 1:length(start_idx)
       
        before_start_idx = start_idx(studied_time) - studied_intervals*fs;
        before_end_idx = start_idx(studied_time);
        before_R_peaks = R_T(R_T >= before_start_idx & R_T <= before_end_idx);
        before_RR_intervals = diff(before_R_peaks);

        [before_mnn, before_sdnn, before_rmssd] = calculate_hrv_parameters(before_R_peaks, fs);
        all_before_mnn(studied_time) = before_mnn;
        all_before_sdnn(studied_time) = before_sdnn;
        all_before_rmssd(studied_time) = before_rmssd;
        
        if(before_start_idx<0)
            before_start_idx = 0;
        end

        [LF_power_before, HF_power_before, LF_HF_ratio_before, ~, ~, TP_power] = HRV_spectral(R_T/fs, before_start_idx/fs, before_end_idx/fs);

        all_before_LF(studied_time) = LF_power_before;
        all_before_HF(studied_time) = HF_power_before;
        all_before_LF_HF_ratio(studied_time) = LF_HF_ratio_before;
        all_before_TP(studied_time) = TP_power;

        
        during_start_idx = start_idx(studied_time);
        during_end_idx = end_idx(studied_time);
        during_R_peaks = R_T(R_T >= during_start_idx & R_T <= during_end_idx);
        during_RR_intervals = diff(during_R_peaks);

        [during_mnn, during_sdnn, during_rmssd] = calculate_hrv_parameters(during_R_peaks, fs);
        all_during_mnn(studied_time) = during_mnn;
        all_during_sdnn(studied_time) = during_sdnn;
        all_during_rmssd(studied_time) = during_rmssd;


        [LF_power_during, HF_power_during, LF_HF_ratio_during, ~, ~, TP_power] = HRV_spectral(R_T/fs, during_start_idx/fs, during_end_idx/fs); 
        all_during_LF(studied_time) = LF_power_during;
        all_during_HF(studied_time) = HF_power_during;
        all_during_LF_HF_ratio(studied_time) = LF_HF_ratio_during;
        all_during_TP(studied_time) = TP_power;

    
        after_start_idx = end_idx(studied_time);
        after_end_idx = end_idx(studied_time) + studied_intervals*fs;
        after_R_peaks = R_T(R_T >= after_start_idx & R_T <= after_end_idx);
        after_RR_intervals = diff(after_R_peaks);

        [after_mnn, after_sdnn, after_rmssd] = calculate_hrv_parameters(after_R_peaks, fs);
        all_after_mnn(studied_time) = after_mnn;
        all_after_sdnn(studied_time) = after_sdnn;
        all_after_rmssd(studied_time) = after_rmssd;

        [LF_power_after, HF_power_after, LF_HF_ratio_after, ~, ~, TP_power] = HRV_spectral(R_T/fs, after_start_idx/fs, after_end_idx/fs);
        all_after_LF(studied_time) = LF_power_after;
        all_after_HF(studied_time) = HF_power_after;
        all_after_LF_HF_ratio(studied_time) = LF_HF_ratio_after;
        all_after_TP(studied_time) = TP_power;


    end

end