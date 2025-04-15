clc
EXP = 4;

fs = 10000;
Ts = 1/fs;
PLOT_ECGS = 0;
SUBPLOTTED = 0;


if EXP == 2
    EXP_folder = "EXP002/data_extracted/";
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R1
    load(EXP_folder+'raton1_est_anestesia.mat')
    
    stim_ref_1                   = stim_reference;
    ECG_1                        = ECG;
    leg_1                        = "R1-EST-AN - EXP002";
    time_1                       = time;
    R_locs_1                     = peak_detection(ECG_1, 0.4, fs);
    [BPM_1, interval_1]          = BMP_calculation(R_locs_1, Ts);
    fprintf(leg_1+"\r\n")
    if PLOT_ECGS == 1
        plot_ECG(time_1, ECG_1, R_locs_1, leg_1)
    end   

    %%%%%%%%%%%%%%%%%%%%%%%%% R2
    load(EXP_folder+'raton2_no_est_anestesia.mat')
    
    stim_ref_2                   = stim_reference;
    ECG_2                        = ECG;    
    leg_2                        = "R2-FAKE - EXP002";
    time_2                       = time;
    R_locs_2                     = peak_detection(ECG_2, 0.6, fs);
    [BPM_2, interval_2]          = BMP_calculation(R_locs_2, Ts);
    fprintf(leg_2+"\r\n")

    if PLOT_ECGS == 1
        plot_ECG(time_2, ECG_2, R_locs_2, leg_2)
    end

elseif EXP == 3
    EXP_folder = "EXP003/data_extracted/inhaled/";
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R1
    load(EXP_folder+'RATON1-AN+EST.mat')
    
    stim_ref_1                   = stim_reference;
    ECG_1                        = ECG;
    leg_1                        = "R1-AN-EST - EXP003";
    time_1                       = time;
    R_locs_1                     = peak_detection(ECG_1, 0.6, fs);
    [BPM_1, interval_1]          = BMP_calculation(R_locs_1, Ts);
    fprintf(leg_1+"\r\n")
    if PLOT_ECGS == 1
        plot_ECG(time_1, ECG_1, R_locs_1, leg_1)
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R2
    load(EXP_folder+'RATON2-EST-AN.mat')
    
    stim_ref_2                   = stim_reference;
    ECG_2                        = ECG;    
    leg_2                        = "R2-EST-AN - EXP003";
    time_2                       = time;
    R_locs_2                     = peak_detection(ECG_2, 0.6, fs);
    [BPM_2, interval_2]          = BMP_calculation(R_locs_2, Ts);
    fprintf(leg_2+"\r\n")

    if PLOT_ECGS == 1
        plot_ECG(time_2, ECG_2, R_locs_2, leg_2)
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R3
    load(EXP_folder+'RATON3-EST-AN.mat')
    
    stim_ref_3                 = stim_reference;
    ECG_3                      = ECG;    
    leg_3                      = "R3-EST-40AN - EXP004";
    time_3                     = time;
    R_locs_3                   = peak_detection(ECG_3, 0.6, fs);
    [BPM_3, interval_3]        = BMP_calculation(R_locs_3, Ts);
    fprintf(leg_3+"\r\n")

   
    if PLOT_ECGS == 1
        plot_ECG(time_3, ECG_3, R_locs_3, leg_3)
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R4
    load(EXP_folder+'RATON4-CONTROL-FALSAEST-AN.mat')
    stim_ref_4                 = stim_reference;
    ECG_4                      = ECG;    
    leg_4                      = "R4-EST-40AN - EXP004";
    time_4                     = time;
    R_locs_4                   = peak_detection(ECG_4, 0.6, fs);
    [BPM_4, interval_4]        = BMP_calculation(R_locs_4, Ts);
    fprintf(leg_4+"\r\n")
    

    if PLOT_ECGS == 1
        plot_ECG(time_4, ECG_4, R_locs_4, leg_4)
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R5
    load(EXP_folder+'RATON5-CONTROL-AN-FALSAEST.mat')
    
    stim_ref_5                = stim_reference;
    ECG_5                     = ECG;    
    leg_5                     = "R5-FAKE - EXP004";
    time_5                    = time;
    R_locs_5                  = peak_detection(ECG_5, 0.6, fs);
    [BPM_5, interval_5]       = BMP_calculation(R_locs_5, Ts);
    fprintf(leg_5+"\r\n")
    

    if PLOT_ECGS == 1
        plot_ECG(time_5, ECG_5, R_locs_5, leg_5)
    end

elseif EXP == 3.2
    EXP_folder = "EXP003/data_extracted/no_inhaled/";
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R1
    load(EXP_folder+'RATON1-30+EST.mat')
    
    stim_ref_1                   = stim_reference;
    ECG_1                        = ECG;
    leg_1                        = "R1-AN-EST - EXP003";
    time_1                       = time;
    R_locs_1                     = peak_detection(ECG_1, 0.6, fs);
    [BPM_1, interval_1]          = BMP_calculation(R_locs_1, Ts);
    fprintf(leg_1+"\r\n")
    if PLOT_ECGS == 1
        plot_ECG(time_1, ECG_1, R_locs_1, leg_1)
    end


    %%%%%%%%%%%%%%%%%%%%%%%%% R2
    load(EXP_folder+'RATON2-EST+30.mat')
    
    stim_ref_2                   = stim_reference;
    ECG_2                        = ECG;    
    leg_2                        = "R2-EST-AN - EXP003";
    time_2                       = time;
    R_locs_2                     = peak_detection(ECG_2, 0.6, fs);
    [BPM_2, interval_2]          = BMP_calculation(R_locs_2, Ts);
    fprintf(leg_2+"\r\n")

    if PLOT_ECGS == 1
        plot_ECG(time_2, ECG_2, R_locs_2, leg_2)
    end



    %%%%%%%%%%%%%%%%%%%%%%%%% R3-1
    load(EXP_folder+'RATON3-EST+15 (1PARTE).mat')
    
    stim_ref_31  = stim_reference;
    ECG_31       = ECG;   

    time_31      = time;
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R3-2
    load(EXP_folder+'RATON3-POST EST-(2PARTE).mat')
    
    stim_ref_3                  = [stim_reference; stim_ref_31];
    ECG_3                       = [ECG_31; ECG];
    time_3                      = [time_31, time];
    leg_3                       = "R3-EST-AN - EXP003";
    R_locs_3                    = peak_detection(ECG_3, 0.6, fs);
    [BPM_3, interval_3]         = BMP_calculation(R_locs_3, Ts);
    fprintf(leg_3+"\r\n")    
    if PLOT_ECGS == 1
        plot_ECG(time_3, ECG_3, R_locs_3, leg_3)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%% R4
    load(EXP_folder+'RATON4-30+EST.mat')
    
    stim_ref_4                  = stim_reference;
    ECG_4                       = ECG; 
    leg_4                       = "R4-FAKE - EXP003";
    time_4                      = time;
    R_locs_4                    = peak_detection(ECG_4, 0.6, fs);
    [BPM_4, interval_4]         = BMP_calculation(R_locs_4, Ts);
    fprintf(leg_4+"\r\n")    
elseif EXP == 4
    EXP_folder = "EXP004/data_extracted/";
    
    %%%%%%%%%%%%%%%%%%%%%%%%% R1
    load(EXP_folder+'RATON1_30AN_30EST_30AN.mat')
    
    stim_ref_1                  = stim_reference;
    ECG_1                       = ECG;
    leg_1                       = "R1-30AN-30EST-30AN - EXP004";
    time_1                      = time;
    R_locs_1                    = peak_detection(ECG_1, 0.6, fs);
    [BPM_1, interval_1]         = BMP_calculation(R_locs_1, Ts);
    fprintf(leg_1+"\r\n")
    if PLOT_ECGS == 1
        plot_ECG(time_1, ECG_1, R_locs_1, leg_1)
    end



    %%%%%%%%%%%%%%%%%%%%%%%%% R2
    load(EXP_folder+'RATON2_30AN_30EST_15AN.mat')
    
    stim_ref_2                 = stim_reference;
    ECG_2                      = ECG;    
    leg_2                      = "R2-30AN-30EST-30AN - EXP004";
    time_2                     = time;
    R_locs_2                   = peak_detection(ECG_2, 0.6, fs);
    [BPM_2, interval_2]        = BMP_calculation(R_locs_2, Ts);
    fprintf(leg_2+"\r\n")
    
    if PLOT_ECGS == 1
        plot_ECG(time_2, ECG_2, R_locs_2, leg_2)
    end




    %%%%%%%%%%%%%%%%%%%%%%%%% R3
    load(EXP_folder+'RATON3_EST_40AN.mat')
    
    stim_ref_3                 = stim_reference;
    ECG_3                      = ECG;    
    leg_3                      = "R3-EST-40AN - EXP004";
    time_3                     = time;
    R_locs_3                   = peak_detection(ECG_3, 0.6, fs);
    [BPM_3, interval_3]        = BMP_calculation(R_locs_3, Ts);
    fprintf(leg_3+"\r\n")

   
    if PLOT_ECGS == 1
        plot_ECG(time_3, ECG_3, R_locs_3, leg_3)
    end




    %%%%%%%%%%%%%%%%%%%%%%%%% R4
    load(EXP_folder+'RATON4_EST_40AN.mat')
    
    stim_ref_4                 = stim_reference;
    ECG_4                      = ECG;    
    leg_4                      = "R4-EST-40AN - EXP004";
    time_4                     = time;
    R_locs_4                   = peak_detection(ECG_4, 0.6, fs);
    [BPM_4, interval_4]        = BMP_calculation(R_locs_4, Ts);
    fprintf(leg_4+"\r\n")
    

    if PLOT_ECGS == 1
        plot_ECG(time_4, ECG_4, R_locs_4, leg_4)
    end





    %%%%%%%%%%%%%%%%%%%%%%%%% R5
    load(EXP_folder+'RATON5_CONTROL_FALSAEST_40AN.mat')
    
    stim_ref_5                = stim_reference;
    ECG_5                     = ECG;    
    leg_5                     = "R5-FAKE - EXP004";
    time_5                    = time;
    R_locs_5                  = peak_detection(ECG_5, 0.6, fs);
    [BPM_5, interval_5]       = BMP_calculation(R_locs_5, Ts);
    fprintf(leg_5+"\r\n")
    

    if PLOT_ECGS == 1
        plot_ECG(time_5, ECG_5, R_locs_5, leg_5)
    end

    %%%%%%%%%%%%%%%%%%%%%%%%% R6
    load(EXP_folder+'RATON6_CONTROL_FALSAEST_40MINAN.mat')
    
    stim_ref_6                = stim_reference;
    ECG_6                     = ECG;    
    leg_6                     = "R6-FAKE - EXP004";
    time_6                    = time;
    R_locs_6                  = peak_detection(ECG_6, 0.4, fs);
    [BPM_6, interval_6]       = BMP_calculation(R_locs_6, Ts);
    fprintf(leg_6+"\r\n")
    

    if PLOT_ECGS == 1
        plot_ECG(time_5, ECG_5, R_locs_5, leg_5)
    end



end

%% 
if (EXP == 2)||(EXP == 3)||(EXP == 3.2)||(EXP == 4)
%%%%%%%%%%%%%%%%%%%%%%%%% R1
plot_ECG_BPM_STIM(time_1, ECG_1, stim_ref_1, interval_1, BPM_1, leg_1, R_locs_1)
fprintf("plot" + leg_1 + "\r\n")    
%%%%%%%%%%%%%%%%%%%%%%%%% R2
%plot_ECG_BPM_STIM(time_2, ECG_2, stim_ref_2, interval_2, BPM_2, leg_2, R_locs_2)
fprintf("plot" + leg_2 + "\r\n")    
    if (EXP == 3)||(EXP == 3.2)||(EXP == 4)
        %%%%%%%%%%%%%%%%%%%%%%%%% R3
 %       plot_ECG_BPM_STIM(time_3, ECG_3, stim_ref_3, interval_3, BPM_3, leg_3, R_locs_3)
        fprintf("plot" + leg_3 + "\r\n")    
        
        %%%%%%%%%%%%%%%%%%%%%%%%% R4
        plot_ECG_BPM_STIM(time_4, ECG_4, stim_ref_4, interval_4, BPM_4, leg_4, R_locs_4)
        fprintf("plot" + leg_4 + "\r\n")    
        if (EXP == 3)||(EXP == 4)
            %%%%%%%%%%%%%%%%%%%%%%%%% R5
  %          plot_ECG_BPM_STIM(time_5, ECG_5, stim_ref_5, interval_5, BPM_5, leg_5, R_locs_5)
            fprintf("plot" + leg_5 + "\r\n")    
            if (EXP == 4)
                %%%%%%%%%%%%%%%%%%%%%%%%% R6
   %             plot_ECG_BPM_STIM(time_6, ECG_6, stim_ref_6, interval_6, BPM_6, leg_6, R_locs_6)
                fprintf("plot" + leg_6 + "\r\n") 
            end
        end 
    end
end
%%
time = {time_1; time_2; time_3; time_4};
ECG = {ECG_1; ECG_2; ECG_3; ECG_4};
stim_ref = {stim_ref_1; stim_ref_2; stim_ref_3; stim_ref_4};
interval = {interval_1; interval_2; interval_3; interval_4};
BPM = {BPM_1; BPM_2; BPM_3; BPM_4};
leg = {leg_1; leg_2; leg_3; leg_4};
R_locs = {R_locs_1; R_locs_2; R_locs_3; R_locs_4};

%%
plot_together(time, ECG, stim_ref, interval, BPM, leg, R_locs)
%% FUNCTIONS

%%function for finding peaks
function R_locs = peak_detection(ECG, th, fs)

    % R-Peak Detection (Using Pan-Tompkins or findpeaks)
    [pks, locs] = findpeaks(ECG,'MinPeakHeight', th);
    
    % 2️ Inicializar lista de picos R detectados
    R_locs = [];
    
    % 3️ Recorrer los picos detectados y tomar el primero de cada par R-T
    i = 1;
    while i < length(locs)
        if i < length(locs) && (locs(i+1) - locs(i)) < fs * 0.1  % Máximo 200 ms entre picos contiguos
            % Comprobamos distancia mínima con el último guardado
            if isempty(R_locs) || (locs(i) - R_locs(end)) >= fs * 0.1  % 100 ms
                R_locs = [R_locs; locs(i)];  % Guardamos el primero del par
            end
            i = i + 2;  % Saltamos el segundo pico (T)
        else
            % Comprobamos distancia mínima con el último guardado
            if isempty(R_locs) || (locs(i) - R_locs(end)) >= fs * 0.1  % 100 ms
                R_locs = [R_locs; locs(i)];  % Guardamos el pico aislado
            end
            i = i + 1;
        end
    end

end
%% Function for calculating the BPM
function [BPM, interval] = BMP_calculation(R_locs, Ts)
    t_R = R_locs*Ts;
    max_time = max(t_R);
    interval = 0:60:max_time+60;
    BPM = histcounts(t_R, interval);
end

%% function for plotting ECG
function plot_ECG(time, ECG, R_locs, legend_id)
        figure
        plot(time, ECG)
        hold on
        plot(time(R_locs), ECG(R_locs), 'o')
        hold off
        title(legend_id)
end

%% Function for plotting ECG + stimulation + BMP
function plot_ECG_BPM_STIM(time, ECG, stim_ref, interval, BPM, legend_id, R_locs)
    figure;
    % Color de fondo (hex -> RGB normalizado)
    fondoRGB = [38, 38, 38]/255;
    lineaRGB = [121, 202, 39]/255;

    
    % Primer eje Y (ECG_1)
    yyaxis left;
    plot(time, ECG);
    ylabel('ECG');
    ylim([-3, 3]);
    hold on
    plot(time, stim_ref, 'Color', 'w');
    plot(time(R_locs), ECG(R_locs), 'r*')
    
    % Segundo eje Y (BPM)
    yyaxis right;
    plot(interval(2:end), BPM, '-o', 'Color', lineaRGB,"LineWidth",2); 
    ylabel('BPM','Color', lineaRGB);
    ylim([90, 550])
    xlabel('Tiempo', 'Color', 'w');
    title(legend_id, 'Color', 'w');
    grid on;
    ax = gca;
    ax.YColor = lineaRGB;                         % Color del eje derecho
    ylabel('BPM', 'Color', lineaRGB);            % Color de la etiqueta del eje derecho

    
    % Estética de la figura
    ax = gca; % Obtener el objeto de ejes
    % Cambiar colores de fondo
    set(gcf, 'Color', fondoRGB);    % Fondo de la figura
    set(ax, 'Color', fondoRGB);     % Fondo del área del gráfico
    % Fuente en blanco
    ax.FontSize = 22;
    ax.FontWeight = 'bold';
    ax.FontName = 'Roboto Light';
   


    
    

end 

%% Function for plotting ECG + stimulation + BMP for all rodents in the experiment
function plot_together(time, ECG, stim_ref, interval, BPM, legend_id, R_locs)
    figure;
    hold on;
    colours = {'r', 'b', 'g', 'k', 'y', 'm'};
    for i = 1:4

        plot(interval{i}(2:end), BPM{i}, colours{i}, "LineWidth",2, 'DisplayName', legend_id{i}); % Gráfica en rojo
        ylabel('BPM');
        ylim([90, 550])
        xlabel('Tiempo (s)');
        
        grid on;
    end
    legend(legend_id, 'Location', 'best');    
    hold off

    
    figure;
    hold on;
    colours = {'r', 'b', 'g', 'k', 'y', 'm'};
    for i = 1:4

        plot(time{i}, stim_ref{i}, colours{i}, "LineWidth",2, 'DisplayName', legend_id{i}); % Gráfica en rojo
        ylabel('BPM');
        xlabel('Tiempo (s)');
        
        grid on;
    end
    legend(legend_id, 'Location', 'best');    
    hold off
end 
