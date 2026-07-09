function [MNN_N_baseline, SDDN_N_baseline, RMSSD_N_baseline, LF_N_baseline, HF_N_baseline, LF_HF_N_baseline, TP_N_baseline, ...
  MNN_N_stimulation, SDDN_N_stimulation, RMSSD_N_stimulation, LF_N_stimulation, HF_N_stimulation, TP_N_stimulation, LF_HF_N_stimulation,...
   MNN_N_rest, SDDN_N_rest, RMSSD_N_rest, LF_N_rest, HF_N_rest, TP_N_rest, LF_HF_N_rest,...
   time_intervals]...
   = calculate_hrv_parameters_small_time(start_idx, end_idx, fs, R_T, small_time)
    baseline_init = 0;
    baseline_end = start_idx(1);
    small_time = small_time*fs;
    
    %Baseline
    number_of_samples = floor((baseline_end - baseline_init)/small_time);
    
    MNN_N_baseline = zeros(1, length(number_of_samples));
    SDDN_N_baseline = zeros(1, length(number_of_samples));
    RMSSD_N_baseline = zeros(1, length(number_of_samples));

    LF_N_baseline = cell(1, length(number_of_samples));
    HF_N_baseline = cell(1, length(number_of_samples));
    LF_HF_N_baseline = cell(1, length(number_of_samples));
    TP_N_baseline = cell(1, length(number_of_samples));
    
    time_intervals = [];
    
    for studied_time = 0:(number_of_samples-1)
        init_t = baseline_init + studied_time*small_time;
        end_t = init_t + small_time;
        if end_t > baseline_end
            end_t = baseline_end;
        end
        baseline_R_peaks = R_T(R_T>=init_t & R_T <= end_t);
    
        [MNN, SDDN, RMSSD] = calculate_hrv_parameters(baseline_R_peaks, fs);
        MNN_N_baseline(studied_time+1) = MNN;
        SDDN_N_baseline(studied_time+1) = SDDN;
        RMSSD_N_baseline(studied_time+1) = RMSSD;
        time_intervals = [time_intervals, init_t];

        [LF, HF, LF_HF, ~, ~, TP] = HRV_spectral(R_T/fs, init_t/fs, end_t/fs);
        LF_N_baseline{studied_time+1} = LF;
        HF_N_baseline{studied_time+1} = HF;
        LF_HF_N_baseline{studied_time+1} = LF_HF;
        TP_N_baseline{studied_time+1} = TP;
        
    end
    
    %During stimulations
    maximum_falues = floor(max((end_idx-start_idx)/small_time));
    
    MNN_N_stimulation = zeros(length(start_idx), length(maximum_falues));
    SDDN_N_stimulation = zeros(length(start_idx), length(maximum_falues));
    RMSSD_N_stimulation = zeros(length(start_idx), length(maximum_falues));

    LF_N_stimulation = cell(length(start_idx), length(maximum_falues));
    TP_N_stimulation = cell(length(start_idx), length(maximum_falues));
    HF_N_stimulation = cell(length(start_idx), length(maximum_falues));
    LF_HF_N_stimulation = cell(length(start_idx), length(maximum_falues));

    for stimulation_repetition = 1:length(start_idx)
        stim_init = start_idx(stimulation_repetition);
        stim_end = end_idx(stimulation_repetition);
    
        number_of_samples = floor((stim_end - stim_init)/small_time);
    
        for studied_time = 0:(number_of_samples-1)
            init_t = stim_init + studied_time*small_time;
            end_t = init_t + small_time;
            if end_t > stim_end
                end_t = stim_end;
            end
            stim_R_peaks = R_T(R_T>=init_t & R_T <= end_t);
    
            [MNN, SDDN, RMSSD] = calculate_hrv_parameters(stim_R_peaks, fs);
            MNN_N_stimulation(stimulation_repetition, studied_time+1) = MNN;
            SDDN_N_stimulation(stimulation_repetition, studied_time+1) = SDDN;
            RMSSD_N_stimulation(stimulation_repetition, studied_time+1) = RMSSD;
            time_intervals = [time_intervals, init_t];

            [LF, HF, LF_HF, ~, ~, TP] = HRV_spectral(R_T/fs, init_t/fs, end_t/fs);

            LF_N_stimulation{stimulation_repetition, studied_time+1} = LF;
            HF_N_stimulation{stimulation_repetition, studied_time+1} = HF;
            LF_HF_N_stimulation{stimulation_repetition, studied_time+1} = LF_HF;
            TP_N_stimulation{stimulation_repetition, studied_time+1} = TP;
     

        end
    end
    
    
    %During rests
    starts_during_rest = end_idx;
    ends_during_rest = [start_idx(2:end); max(R_T)];
    maximum_falues = floor(max((ends_during_rest-starts_during_rest)/small_time));
    
    MNN_N_rest = zeros(length(start_idx), length(maximum_falues));
    SDDN_N_rest = zeros(length(start_idx), length(maximum_falues));
    RMSSD_N_rest = zeros(length(start_idx), length(maximum_falues));

    LF_N_rest = cell(length(start_idx), length(maximum_falues));
    HF_N_rest = cell(length(start_idx), length(maximum_falues));
    TP_N_rest = cell(length(start_idx), length(maximum_falues));
    LF_HF_N_rest = cell(length(start_idx), length(maximum_falues));

    for resting_repetition = 1:length(start_idx)
        rest_init = starts_during_rest(resting_repetition);
        rest_end = ends_during_rest(resting_repetition);
    
        number_of_samples = floor((rest_end - rest_init)/small_time);

        for studied_time = 0:(number_of_samples-1)

            init_t = rest_init + studied_time*small_time;
            end_t = init_t + small_time;
            if end_t > rest_end
                end_t = rest_end;
            end
            rest_R_peaks = R_T(R_T>=init_t & R_T <= end_t);
            
            [MNN, SDDN, RMSSD] = calculate_hrv_parameters(rest_R_peaks, fs);

            MNN_N_rest(resting_repetition, studied_time+1) = MNN;
            SDDN_N_rest(resting_repetition, studied_time+1) = SDDN;
            RMSSD_N_rest(resting_repetition, studied_time+1) = RMSSD;
            time_intervals = [time_intervals, init_t];


            [LF, HF, LF_HF, ~, ~, TP] = HRV_spectral(R_T/fs, init_t/fs, end_t/fs);

            LF_N_rest{resting_repetition, studied_time+1} = LF;
            HF_N_rest{resting_repetition, studied_time+1} = HF;
            TP_N_rest{resting_repetition, studied_time+1} = TP;
            LF_HF_N_rest{resting_repetition, studied_time+1} = LF_HF;

        end 
    end


end