function functions_plotting_booleaned( ...
    time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_Q_init, locs_Q_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, label, initial_time, end_time, ...
    PQRST, PQRST_PARTITION, ECG_plot, INDICATORS_TOGETHER, INDICATORS, INDICATORS_DIFFERENCED, BPM_plot, PT_plot)
    if PQRST == true
        plot_PRQRST(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, initial_time, end_time);
    end
    if PQRST_PARTITION == true
     plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, 1000);
     plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, 2000);
     plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, 4000); 
    end
    if ECG_plot == true
      plot_ECG(time, ECG, stimulation, label, initial_time, end_time);
    end
    if INDICATORS_TOGETHER == true
        plot_indicators(time, stimulation, PR, PS, RS, RT, QRS, QT, ST, locs_P, locs_Q, locs_R, locs_S, locs_T, label, initial_time, end_time);
    end
    if INDICATORS_DIFFERENCED == true
        plot_indicator(time, stimulation, PR, locs_P, label, "PR", [0, 0.1], initial_time, end_time)
        plot_indicator(time, stimulation, PS, locs_P, label, "PS", [0, 0.1], initial_time, end_time)
        plot_indicator(time, stimulation, RS, locs_R, label, "RS", [0, 0.02], initial_time, end_time)
        plot_indicator(time, stimulation, RT, locs_R, label, "RT", [0, 0.02], initial_time, end_time)
        plot_indicator(time, stimulation, QRS, locs_Q, label, "QRS", [0, 0.1], initial_time, end_time)
        plot_indicator(time, stimulation, QT, locs_Q, label, "QT", [0, 0.2], initial_time, end_time)
        plot_indicator(time, stimulation, ST, locs_S, label, "ST", [0, 0.02], initial_time, end_time)
        plot_indicator(time, stimulation, RT_voltage, locs_R, label, "RT VOLTAGE", [-1, 1], initial_time, end_time)
        plot_indicator(time, stimulation, RR, locs_R(1:end-1), label, "RR", [0, 1], initial_time, end_time)
    end
    if INDICATORS == true
        plot_indicators_differenced(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, label, initial_time, end_time)
    end
    if BPM_plot == true
        plot_BPM(time, stimulation, time_intervals_bpm, BPM, label, initial_time, end_time)
    end
    if PT_plot == true
        plot_P(time, locs_P, locs_P_init, locs_P_end, ECG, initial_time, end_time)
        plot_T(time, locs_Q, locs_Q_init, locs_Q_end, ECG, initial_time, end_time)
    end

end
%% function for plotting ECG
function plot_ECG(time, ECG, stimulation, label, initial_time, end_time)
        figure('Units','normalized','OuterPosition',[0 0 1 1]);
        plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
        hold on
        yyaxis right;        
        plot(time, ECG, "Color", [0 0.4470 0.7410])
        xlim([initial_time, end_time])

        legend('Stimulation', 'ECG');
        hold off
        title(label)
end
%% function for plotting ECG + PQRST
function plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, N)
        figure('Units','normalized','OuterPosition',[0 0 1 1]);
        hold on
        plot(time, ECG, "Color", [0 0.4470 0.7410])
        plot(time(locs_P), ECG(locs_P), 'mo')
        plot(time(locs_Q), ECG(locs_Q), 'ko')
        plot(time(locs_R), ECG(locs_R), 'ro')
        plot(time(locs_S), ECG(locs_S), 'go')
        plot(time(locs_T), ECG(locs_T), 'bo')
        xlim([N, N+2])
        legend('ECG', 'P','Q','R','S','T');
        hold off
        title(label)
end
%% function for plotting ECG + PQRST
function plot_PRQRST(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, initial_time, end_time)
        figure('Units','normalized','OuterPosition',[0 0 1 1]);
        plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
        hold on
        yyaxis right;        
        plot(time, ECG, "Color", [0 0.4470 0.7410])
        plot(time(locs_P), ECG(locs_P), 'mo')
        plot(time(locs_Q), ECG(locs_Q), 'ko')
        plot(time(locs_R), ECG(locs_R), 'ro')
        plot(time(locs_S), ECG(locs_S), 'go')
        plot(time(locs_T), ECG(locs_T), 'bo')
        ylim([min(ECG)-0.2, max(ECG)+0.2])
        xlim([initial_time, end_time])
        legend('Stimulation', 'ECG', 'P','Q','R','S','T');
        hold off
        title(label)
end


%% function for plotting indicators
function plot_indicators(time, stimulation, PR, PS, RS, RT, QRS, QT, ST, locs_P, locs_Q, locs_R, locs_S, locs_T, label, initial_time, end_time)
    figure('Units','normalized','OuterPosition',[0 0 1 1]);
    % Primer eje Y (estimulacion)
    yyaxis left;
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])

    % Segundo eje Y (indicadores)
    yyaxis right;
    hold on
    plot(time(locs_P), PR, '-m')
    plot(time(locs_P), PS, '-k')
    plot(time(locs_R), RS, '-r')
    plot(time(locs_R), RT, '-g')
    plot(time(locs_Q), QRS, '-b')
    plot(time(locs_Q), QT, 'Color', [0.8500 0.3250 0.0980], 'LineStyle','-')
    plot(time(locs_S), ST, 'Color', [0.4660 0.6740 0.1880], 'LineStyle','-')
    xlim([initial_time, end_time])
    
    hold off
    title(label)
    legend('Stimulation', 'PR', 'PS', 'RS', 'RT', 'QRS', 'QT', 'ST')
end

%% function for plotting indicator XX
function plot_indicator(time, stimulation, XX, locs_XX, label, indicator, limits, initial_time, end_time)
    figure('Units','normalized','OuterPosition',[0 0 1 1]);
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_XX), XX, "Color", [0 0.4470 0.7410])
    ylim(limits)
    xlim([initial_time, end_time])
    hold off

    title(label + " " + indicator)
    legend('Stimulation', indicator)
end

%% function for plotting the BPM
function plot_BPM(time, stimulation, time_intervals, BPM, label, initial_time, end_time)
    figure('Units','normalized','OuterPosition',[0 0 1 1]);
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time_intervals, BPM, "Color", [0 0.4470 0.7410])
    xlim([initial_time, end_time])
    hold off

    title(label + " BPM "  )
    legend('Stimulation', 'BPM')
end

%% function for plotting all indicators in the same view with different plots

function plot_indicators_differenced(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, label, initial_time, end_time)
    
    figure('Units','normalized','OuterPosition',[0 0 1 1]);    
    % Create plots
    tiledlayout(2,2);

    
    %%%% PR
    nexttile
    plot(time, stimulation, "Color", [0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_P), PR,  "Color", [0 0.4470 0.7410])
    ylim([0, mean(PR)*2])
    xlim([initial_time, end_time])
    hold off

    title(label + " PR ")

    %%%% PS
    nexttile
    plot(time, stimulation, "Color", [0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_P), PS, "Color", [0 0.4470 0.7410])
    ylim([0, mean(PS)*2])
    xlim([initial_time, end_time])
    hold off

    title(label + " PS ")

    %%%% RS
    nexttile
    plot(time, stimulation, "Color", [0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_R), RS, "Color", [0 0.4470 0.7410])
    ylim([0, mean(RS)*2])
    xlim([initial_time, end_time])
    hold off

    title(label + " RS ")

    %%%% RT
    nexttile
    plot(time, stimulation, "Color", [0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_R), RT, "Color", [0 0.4470 0.7410])
    ylim([0, mean(RT)*2])
    xlim([initial_time, end_time])
    hold off

    title(label + " RT ")

    figure('Units','normalized','OuterPosition',[0 0 1 1]);
    % Create plots
    tiledlayout(2,2);

    
    %%%% QRS
    nexttile
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_Q), QRS, "Color", [0 0.4470 0.7410])
    ylim([0, mean(QRS)*2])
    xlim([initial_time, end_time])
    hold off

    title(label + " QRS ")

    %%%% QT
    nexttile
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_Q), QT, "Color", [0 0.4470 0.7410])
    ylim([0, mean(QT)*2])
    xlim([initial_time, end_time])
    hold off

    title(label + " QT ")

    %%%% ST
    nexttile
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_S), ST, "Color", [0 0.4470 0.7410])
    ylim([0, mean(ST)*2])
    xlim([initial_time, end_time])
    hold off

    title(label + " ST ")

    %%%% RT VOLTAGE
    nexttile
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on
    % Segundo eje Y (diferencia de tensión)
    yyaxis right;
    plot(time(locs_R), RT_voltage,  "Color", [0 0.4470 0.7410])    
    ylim([-mean(RT_voltage)*2, mean(RT_voltage)*2])
    xlim([initial_time, end_time])
    hold off
    title(label + " RT voltage ")

end


%% function for plotting the P and Q indicated separately
function plot_P(time, locs_P, locs_P_init, locs_P_end, ECG, initial_time, end_time)
    figure('Units','normalized','OuterPosition',[0 0 1 1]);
    plot(time, ECG)
    hold on

    % Segundo eje Y (indicadores)
    plot(time(locs_P), ECG(locs_P), 'o')
    plot(time(locs_P_init), ECG(locs_P_init), '*')
    plot(time(locs_P_end), ECG(locs_P_end), '.')
    xlim([initial_time, end_time])
    hold off

    title('P wave ')
    legend('ECG', 'P center', 'P init', 'P end')
end

function plot_T(time, locs_T, locs_T_init, locs_T_end, ECG, initial_time, end_time)
    figure('Units','normalized','OuterPosition',[0 0 1 1]);
    plot(time, ECG)
    hold on

    % Segundo eje Y (indicadores)
    plot(time(locs_T), ECG(locs_T), 'o')
    plot(time(locs_T_init), ECG(locs_T_init), '*')
    plot(time(locs_T_end), ECG(locs_T_end), '.')
    xlim([initial_time, end_time])
    hold off


    title('T wave')
    legend('ECG', 'T center', 'T init', 'T end')
end



