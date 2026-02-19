function plot_with_peaks_VNS(Experiments, rodent, experiment_number)
    experiment = Experiments(rodent).experiment_number(experiment_number);

    mwi_signal = experiment.obtained_signals.mwi_signal;
    t = experiment.obtained_signals.time;
    A_T = experiment.marquers.R_T;
    th_ECG_inf = experiment.function_parameters.threshold;
    ECG = experiment.obtained_signals.ECG;
    
    figure
    plot(t, mwi_signal);
    title('Moving Average with peaks');
    xlabel('Time [s]');
    ylabel('Amplitude');
    hold on
    plot(t(A_T), mwi_signal(A_T), '*');
    yline(th_ECG_inf, '--r', 'Threshold');
    hold off


    figure
    plot(t, ECG);
    title('ECG with peaks');
    xlabel('Time [s]');
    ylabel('Amplitude');
    hold on
    plot(t(A_T), ECG(A_T), '*');
    hold off

end
