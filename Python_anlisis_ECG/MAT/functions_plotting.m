function functions_plotting(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_Q_init, locs_Q_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, label)
    plot_PRQRST(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label);
    %  plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, 1000);
    %  plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, 2000);
    %  plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, 4000); 
    %  plot_ECG(time, ECG, stimulation, label);
    % plot_indicators(time, stimulation, PR, PS, RS, RT, QRS, QT, ST, locs_P, locs_Q, locs_R, locs_S, locs_T, label);
    % plot_indicator(time, stimulation, PR, locs_P, label, 'PR', [0, 0.1])
    % plot_indicator(time, stimulation, PS, locs_P, label, 'PS', [0, 0.1])º
    % plot_indicator(time, stimulation, RS, locs_R, label, 'RS', [0, 0.02])
    % plot_indicator(time, stimulation, RT, locs_R, label, 'RT', [0, 0.02])
    % plot_indicator(time, stimulation, QRS, locs_Q, label, 'QRS', [0, 0.1])
    % plot_indicator(time, stimulation, QT, locs_Q, label, 'QT', [0, 0.2])
    % plot_indicator(time, stimulation, ST, locs_S, label, 'ST', [0, 0.02])
    % plot_indicator(time, stimulation, RT_voltage, locs_R, label, 'RT VOLTAGE', [-1, 1])
    % plot_indicator(time, stimulation, RR, locs_R(1:end-1), label, 'RR', [0, 1])
    % plot_indicators_differenced(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, label)
    % plot_BPM(time, stimulation, time_intervals_bpm, BPM, label)
    % plot_P(time, locs_P, locs_P_init, locs_P_end, ECG)
    % plot_T(time, locs_Q, locs_Q_init, locs_Q_end, ECG)


end
