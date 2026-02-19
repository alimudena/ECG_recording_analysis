function [] = plot_ECG_and_HRV(Experiments, rodent, experiment_number)
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
    figure;
    % --- ECG left axis---
    % yyaxis left
    plot(t, ECG);
    xlabel('Time (s)');
    ylabel('ECG (mV)');
    grid on
    hold on
    title('ECG with HRV beat by beat (RR)');


    % --- BPM right axis---
    yyaxis right
    plot(t_HRV, HRV, 'MarkerSize', 12);
    ylabel('HRV');

end