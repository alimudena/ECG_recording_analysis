function [] = plot_ECG_and_PPM_and_stim(Experiments, rodent, experiment_number)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    Experiments
    rodent
    experiment_number
end

arguments (Output)
end
    experiment = Experiments(rodent).experiment_number(experiment_number);
    ECG = experiment.obtained_signals.ECG;
    t = experiment.obtained_signals.time;
    HRV = experiment.marquers.HRV;
    t_HRV = experiment.marquers.HRV_t;
    start_times = experiment.obtained_signals.start_stim_positions;
    end_times = experiment.obtained_signals.end_stim_positions;
    figure;
    % --- ECG left axis---
    % yyaxis left
    plot(t, ECG);
    xlabel('Time (s)');
    ylabel('ECG (mV)');
    grid on
    hold on
    title('ECG with PPM beat by beat (RR) and stimulation start and end');


    % --- BPM right axis---
    yyaxis right
    plot(t_HRV, 60./HRV, 'MarkerSize', 12);
    ylabel('PPM');

        % LÃ­neas de inicio (verde)
    for i = 1:length(start_times)
        xline(t(start_times(i)), 'g--', 'LineWidth', 1.5);
    end
    
    % LÃ­neas de fin (rojo)
    for i = 1:length(end_times)
        xline(t(end_times(i)), 'r--', 'LineWidth', 1.5);
    end

end