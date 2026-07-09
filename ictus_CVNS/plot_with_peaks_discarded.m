function plot_with_peaks_discarded(Experiments, rodent, experiment_number)
    experiment = Experiments(rodent).experiment_number(experiment_number);

    mwi_signal = experiment.obtained_signals.mwi_signal;
    ECG = experiment.obtained_signals.ECG;
    t = experiment.obtained_signals.time;
    th_ECG_inf = experiment.function_parameters.Threshold;
    th_ECG_sup = experiment.function_parameters.Threshold_sup;
    fs = experiment.obtained_signals.sampling_frequency;


    start_times = experiment.obtained_signals.start_stim_positions;
    end_times = experiment.obtained_signals.end_stim_positions;

    peak_distance = experiment.function_parameters.Peak_distance;

    mwi_smooth = movmean(mwi_signal, round(0.01*fs)); 
    [R, R_T] = findpeaks(mwi_smooth, 'MinPeakDistance', peak_distance);
    % idx = R > th_ECG_inf;
    idx = (R > th_ECG_inf) & (R < th_ECG_sup);

    figure
    plot(mwi_smooth)
    hold on
    plot(R_T(~idx), R(~idx), '.r')
    plot(R_T(idx),  R(idx),  '.g')
    yline(th_ECG_inf,'k')

    % LÃ­neas de inicio (verde)
    for i = 1:length(start_times)
        xline(start_times(i), 'g--', 'LineWidth', 1.5);
    end
    
    % LÃ­neas de fin (rojo)
    for i = 1:length(end_times)
        xline(end_times(i), 'r--', 'LineWidth', 1.5);
    end

    figure
    plot(ECG)
    hold on
    plot(R_T(~idx), ECG(~idx), '.r')
    plot(R_T(idx),  ECG(idx),  '.g')


    % LÃ­neas de inicio (verde)
    for i = 1:length(start_times)
        xline(start_times(i), 'g--', 'LineWidth', 1.5);
    end
    
    % LÃ­neas de fin (rojo)
    for i = 1:length(end_times)
        xline(end_times(i), 'r--', 'LineWidth', 1.5);
    end

end
