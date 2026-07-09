for i = 1:3
    plot_ECG_and_HRV_and_stim(Experiments, 2, i);

end






%%
plot_ECG_and_HRV_and_stim(Experiments, 1, 3);







%%


Experiments(1).experiment_number(2).obtained_signals.start_stim_positions(1)/fs

Experiments(1).experiment_number(3).obtained_signals.start_stim_positions(1)/fs


%%
for i = 1:3

    miVariable = Experiments(1).experiment_number(i).obtained_signals.start_stim_positions(1)/fs;
    fprintf('R01 sesion %d: %f\n', i,  miVariable);

end

for i = 1:3
    miVariable = Experiments(4).experiment_number(i).obtained_signals.start_stim_positions(1)/fs;
    fprintf('R04 sesion %d: %f\n', i,  miVariable);

end


%%
for i = 1:3
    % plot_ECG_and_PPM_and_stim(Experiments, rodent, experiment_number);
    plot_with_peaks_discarded(Experiments, 4, i);
end