function plot_with_peaks_VNS(Experiments, rodent, experiment_number)
    experiment = Experiments(rodent).experiment_number(experiment_number);

    mwi_signal = experiment.obtained_signals.mwi_signal;
    t = experiment.obtained_signals.time;
    A_T = experiment.marquers.R_T;
    th_ECG_inf = experiment.function_parameters.Threshold;
    ECG = experiment.obtained_signals.ECG;
    start_times = experiment.obtained_signals.start_stim_positions;
    end_times = experiment.obtained_signals.end_stim_positions;


    figure
    plot(t, mwi_signal);
    title('Moving Average with peaks');
    xlabel('Time [s]');
    ylabel('Amplitude');
    hold on
    plot(t(A_T), mwi_signal(A_T), '*');
    yline(th_ECG_inf, '--r', 'Threshold');
    % LÃƒÂ­neas de inicio (verde)
    for i = 1:length(start_times)
        xline(t(start_times(i)), 'g--', 'LineWidth', 1.5);
    end
    
    % LÃƒÂ­neas de fin (rojo)
    for i = 1:length(end_times)
        xline(t(end_times(i)), 'r--', 'LineWidth', 1.5);
    end
    hold off


    figure
    plot(t, ECG);
    title('ECG with peaks');
    xlabel('Time [s]');
    ylabel('Amplitude');
    hold on
    plot(t(A_T), ECG(A_T), '*');
    % LÃƒÂ­neas de inicio (verde)
    for i = 1:length(start_times)
        xline(t(start_times(i)), 'g--', 'LineWidth', 1.5);
    end
    
    % LÃƒÂ­neas de fin (rojo)
    for i = 1:length(end_times)
        xline(t(end_times(i)), 'r--', 'LineWidth', 1.5);
    end
    hold off

end
