function functions_plotting(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, locs_Q_init, locs_Q_end, locs_P_init, locs_P_end, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, RR, time_intervals_bpm, BPM, label)
     plot_PRQRST(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label);
     plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, 1000);
     plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, 2000);
     plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, 4000); 
     plot_ECG(time, ECG, stimulation, label);
    plot_indicators(time, stimulation, PR, PS, RS, RT, QRS, QT, ST, locs_P, locs_Q, locs_R, locs_S, locs_T, label);
    % plot_indicator(time, stimulation, PR, locs_P, label, 'PR', [0, 0.1])
    % plot_indicator(time, stimulation, PS, locs_P, label, 'PS', [0, 0.1])
    % plot_indicator(time, stimulation, RS, locs_R, label, 'RS', [0, 0.02])
    % plot_indicator(time, stimulation, RT, locs_R, label, 'RT', [0, 0.02])
    % plot_indicator(time, stimulation, QRS, locs_Q, label, 'QRS', [0, 0.1])
    % plot_indicator(time, stimulation, QT, locs_Q, label, 'QT', [0, 0.2])
    % plot_indicator(time, stimulation, ST, locs_S, label, 'ST', [0, 0.02])
    % plot_indicator(time, stimulation, RT_voltage, locs_R, label, 'RT VOLTAGE', [-1, 1])
    % plot_indicator(time, stimulation, RR, locs_R(1:end-1), label, 'RR', [0, 1])
    plot_indicators_differenced(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, label)
    plot_BPM(time, stimulation, time_intervals_bpm, BPM, label)
    % plot_P(time, locs_P, locs_P_init, locs_P_end, ECG)
    % plot_T(time, locs_Q, locs_Q_init, locs_Q_end, ECG)


end
%% function for plotting ECG
function plot_ECG(time, ECG, stimulation, label)
        figure
        plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
        hold on
        yyaxis right;        
        plot(time, ECG, "Color", [0 0.4470 0.7410])
        legend('Stimulation', 'ECG');
        hold off
        title(label)
end
%% function for plotting ECG + PQRST
function plot_PRQRST_partition_N(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label, N)
        figure
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
function plot_PRQRST(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, label)
        figure
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
        legend('Stimulation', 'ECG', 'P','Q','R','S','T');
        hold off
        title(label)
end


%% function for plotting indicators
function plot_indicators(time, stimulation, PR, PS, RS, RT, QRS, QT, ST, locs_P, locs_Q, locs_R, locs_S, locs_T, label)
    figure
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
    
    hold off
    title(label)
    legend('Stimulation', 'PR', 'PS', 'RS', 'RT', 'QRS', 'QT', 'ST')
end

%% function for plotting indicator XX
function plot_indicator(time, stimulation, XX, locs_XX, label, indicator, limits)
    figure
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_XX), XX, "Color", [0 0.4470 0.7410])
    ylim(limits)
    hold off

    title(label + ' ' + indicator)
    legend('Stimulation', indicator)
end

%% function for plotting the BPM
function plot_BPM(time, stimulation, time_intervals, BPM, label)
    figure
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time_intervals, BPM, "Color", [0 0.4470 0.7410])
    hold off

    title(label + ' BPM ')
    legend('Stimulation', 'BPM')
end

%% function for plotting all indicators in the same view with different plots

function plot_indicators_differenced(time, ECG, stimulation, locs_P, locs_Q, locs_R, locs_S, locs_T, PR, PS, RS, RT, QRS, QT, ST, RT_voltage, label)
    
    figure    
    % Create plots
    tiledlayout(2,2);

    
    %%%% PR
    nexttile
    plot(time, stimulation, "Color", [0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_P), PR,  "Color", [0 0.4470 0.7410])
    ylim([0, max(PR)+0.02])
    hold off

    title(label + ' PR ')
    legend('Stimulation', 'PR')

    %%%% PS
    nexttile
    plot(time, stimulation, "Color", [0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_P), PS, "Color", [0 0.4470 0.7410])
    ylim([0, max(PS)+0.02])
    hold off

    title(label + ' PS ')

    %%%% RS
    nexttile
    plot(time, stimulation, "Color", [0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_R), RS, "Color", [0 0.4470 0.7410])
    ylim([0, max(RS)+0.02])
    hold off

    title(label + ' RS ')
    legend('Stimulation', 'RS')

    %%%% RT
    nexttile
    plot(time, stimulation, "Color", [0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_R), RT, "Color", [0 0.4470 0.7410])
    ylim([0, max(RT)+0.02])
    hold off

    title(label + ' RT ')
    legend('Stimulation', 'RT')

    figure
    % Create plots
    tiledlayout(2,2);

    
    %%%% QRS
    nexttile
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_Q), QRS, "Color", [0 0.4470 0.7410])
    ylim([0, max(QRS)+0.02])
    hold off

    title(label + ' QRS ')
    legend('Stimulation', 'QRS')    

    %%%% QT
    nexttile
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_Q), QT, "Color", [0 0.4470 0.7410])
    ylim([0, max(QT)+0.02])
    hold off

    title(label + ' QT ')
    legend('Stimulation', 'QT')

    %%%% ST
    nexttile
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on

    % Segundo eje Y (indicadores)
    yyaxis right;
    plot(time(locs_S), ST, "Color", [0 0.4470 0.7410])
    ylim([0, max(ST)+0.02])
    hold off

    title(label + ' ST ')
    legend('Stimulation', 'ST')

    %%%% RT VOLTAGE
    nexttile
    plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
    hold on
    % Segundo eje Y (diferencia de tensión)
    yyaxis right;
    plot(time(locs_R), RT_voltage,  "Color", [0 0.4470 0.7410])    
    hold off
    title(label + ' RT voltage ')

end


%% function for plotting the P and Q indicated separately
function plot_P(time, locs_P, locs_P_init, locs_P_end, ECG)
    figure
    plot(time, ECG)
    hold on

    % Segundo eje Y (indicadores)
    plot(time(locs_P), ECG(locs_P), 'o')
    plot(time(locs_P_init), ECG(locs_P_init), '*')
    plot(time(locs_P_end), ECG(locs_P_end), '.')
    hold off

    title('P wave ')
    legend('ECG', 'P center', 'P init', 'P end')
end

function plot_T(time, locs_T, locs_T_init, locs_T_end, ECG)
    figure
    plot(time, ECG)
    hold on

    % Segundo eje Y (indicadores)
    plot(time(locs_T), ECG(locs_T), 'o')
    plot(time(locs_T_init), ECG(locs_T_init), '*')
    plot(time(locs_T_end), ECG(locs_T_end), '.')
    hold off


    title('T wave')
    legend('ECG', 'T center', 'T init', 'T end')
end


%% Functions for each indicator with its own parameters
% %% function for plotting indicator PR
% function plot_indicator_PR(time, stimulation, PR, locs_P, label)
%     figure
%     plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
%     hold on
% 
%     % Segundo eje Y (indicadores)
%     yyaxis right;
%     plot(time(locs_P), PR, "Color", [0 0.4470 0.7410])
%     ylim([0, 0.1])
%     hold off
% 
%     title(label + ' PR ')
%     legend('Stimulation', 'PR')
% end
% 
% %% function for plotting indicator PS
% function plot_indicator_PS(time, stimulation, PS, locs_P, label)
%     figure
%     plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
%     hold on
% 
%     % Segundo eje Y (indicadores)
%     yyaxis right;
%     plot(time(locs_P), PS, "Color", [0 0.4470 0.7410])
%     ylim([0, 0.1])
%     hold off
% 
%     title(label + ' PS ')
%     legend('Stimulation', 'PS')
% 
% end
% 
% %% function for plotting indicator RS
% function plot_indicator_RS(time, stimulation, RS, locs_R, label)
%     figure
%     plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
%     hold on
% 
%     % Segundo eje Y (indicadores)
%     yyaxis right;
%     plot(time(locs_R), RS, "Color", [0 0.4470 0.7410])
%     ylim([0, 0.03])
%     hold off
% 
%     title(label + ' RS ')
%     legend('Stimulation', 'RS')
% 
% end
% 
% %% function for plotting indicator RT
% function plot_indicator_RT(time, stimulation, RT, locs_R, label)
%     figure
%     plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
%     hold on
% 
%     % Segundo eje Y (indicadores)
%     yyaxis right;
%     plot(time(locs_R), RT, "Color", [0 0.4470 0.7410])
%     ylim([0, 0.03])
%     hold off
% 
%     title(label + ' RT ')
%     legend('Stimulation', 'RT')
% 
% end
% 
% %% function for plotting indicator QRS
% function plot_indicator_QRS(time, stimulation, QRS, locs_Q, label)
%     figure
%     plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
%     hold on
% 
%     % Segundo eje Y (indicadores)
%     yyaxis right;
%     plot(time(locs_Q), QRS, "Color", [0 0.4470 0.7410])
%     ylim([0, 0.06])
%     hold off
% 
%     title(label + ' QRS ')
%     legend('Stimulation', 'QRS')
% 
% end
% 
% 
% %% function for plotting indicator QT
% function plot_indicator_QT(time, stimulation, QT, locs_Q, label)
%     figure
%     plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
%     hold on
% 
%     % Segundo eje Y (indicadores)
%     yyaxis right;
%     plot(time(locs_Q), QT, "Color", [0 0.4470 0.7410])
%     ylim([0, 0.06])
%     hold off
% 
%     title(label + ' QT ')
%     legend('Stimulation', 'QT')
% 
% end
% %% function for plotting indicator ST
% function plot_indicator_ST(time, stimulation, ST, locs_S, label)
%     figure
%     plot(time, stimulation, "Color",[0.4940 0.1840 0.5560])
%     hold on
% 
%     % Segundo eje Y (indicadores)
%     yyaxis right;
%     plot(time(locs_S), ST, "Color", [0 0.4470 0.7410])
%     ylim([0, 0.06])
%     hold off
% 
%     title(label + ' ST ')
%     legend('Stimulation', 'ST')
% 
% end
% %% function for plotting indicator RT voltage
% function plot_indicator_RT_voltage(time, stimulation, RT_voltage, locs_R, label)
%     figure
%     plot(time, stimulation, "Color", [0.4940 0.1840 0.5560])
%     hold on
%     % Segundo eje Y (diferencia de tensión)
%     yyaxis right;
%     plot(time(locs_R), RT_voltage,  "Color", [0 0.4470 0.7410])    
%     hold off
%     title(label + ' RT voltage ')
% 
% end
% 
% %% funciton for plotting indicator PP
% function plot_indicator_RR(time, stimulation, RR, locs_R, label)
%     figure
%     plot(time, stimulation, "Color", [0.4940 0.1840 0.5560])
%     hold on
%     % Segundo eje Y (diferencia de tensión)
%     yyaxis right;
%     plot(time(locs_R(1:end-1)), RR,  "Color", [0 0.4470 0.7410])    
%     ylim([0, 1])
%     hold off
%     title(label + ' RR ')
% 
% 
% 
% end
