function [HRV_parameters, TablaComparativa] = HRV_pvalues_extraction(Experiments)
%UNTITLED Summary of this function goes here
%Detailed explanation goes here
    arguments (Input)
        Experiments
    end
    
    arguments (Output)
        HRV_parameters
        TablaComparativa
    end
    
    MNN_mean_experiments_baseline = [];
    MNN_mean_experiments_final_pause = [];
    
    SDNN_mean_experiments_baseline = [];
    SDNN_mean_experiments_final_pause = [];
    
    RMSSD_mean_experiments_baseline = [];
    RMSSD_mean_experiments_final_pause = [];
    
    LF_mean_experiments_baseline = [];
    LF_mean_experiments_final_pause = [];
    
    HF_mean_experiments_baseline = [];
    HF_mean_experiments_final_pause = [];
    
    TP_mean_experiments_baseline = [];
    TP_mean_experiments_final_pause = [];

    LF_HF_ratio_mean_experiments_baseline = [];
    LF_HF_ratio_mean_experiments_final_pause = [];

    for rodent_n = 1:length(Experiments)
        for experiment_n = 1:length(Experiments(rodent_n).experiment_number)
            MNN_experiment_baseline = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_MNN(1);
            MNN_mean_experiments_baseline = [MNN_mean_experiments_baseline, MNN_experiment_baseline];
            MNN_experiments_final_pause = Experiments(rodent_n).experiment_number(experiment_n).marquers.after_MNN(end);
            MNN_mean_experiments_final_pause = [MNN_mean_experiments_final_pause, MNN_experiments_final_pause];
    
            SDNN_experiment_baseline = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_SDNN(1);
            SDNN_mean_experiments_baseline = [SDNN_mean_experiments_baseline, SDNN_experiment_baseline];
            SDNN_experiments_final_pause = Experiments(rodent_n).experiment_number(experiment_n).marquers.after_SDNN(end);
            SDNN_mean_experiments_final_pause = [SDNN_mean_experiments_final_pause, SDNN_experiments_final_pause];
    
            RMSSD_experiment_baseline = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_RMSSD(1);
            RMSSD_mean_experiments_baseline = [RMSSD_mean_experiments_baseline, RMSSD_experiment_baseline];
            RMSSD_experiments_final_pause = Experiments(rodent_n).experiment_number(experiment_n).marquers.after_RMSSD(end);
            RMSSD_mean_experiments_final_pause = [RMSSD_mean_experiments_final_pause, RMSSD_experiments_final_pause];
    
            LF_experiment_baseline = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_LF(1);
            LF_mean_experiments_baseline = [LF_mean_experiments_baseline, LF_experiment_baseline];
            LF_experiments_final_pause = Experiments(rodent_n).experiment_number(experiment_n).marquers.after_LF(end);
            LF_mean_experiments_final_pause = [LF_mean_experiments_final_pause, LF_experiments_final_pause];
    
            HF_experiment_baseline = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_HF(1);
            HF_mean_experiments_baseline = [HF_mean_experiments_baseline, HF_experiment_baseline];
            HF_experiments_final_pause = Experiments(rodent_n).experiment_number(experiment_n).marquers.after_HF(end);
            HF_mean_experiments_final_pause = [HF_mean_experiments_final_pause, HF_experiments_final_pause];
            
            TP_experiment_baseline = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_TP(1);
            TP_mean_experiments_baseline = [TP_mean_experiments_baseline, TP_experiment_baseline];
            TP_experiments_final_pause = Experiments(rodent_n).experiment_number(experiment_n).marquers.after_TP(end);
            TP_mean_experiments_final_pause = [TP_mean_experiments_final_pause, TP_experiments_final_pause];
    
            LF_HF_ratio_baseline = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_LF_HF_ratio(1);
            LF_HF_ratio_mean_experiments_baseline = [LF_HF_ratio_mean_experiments_baseline, LF_HF_ratio_baseline];
            LF_HF_ratio_experiments_final_pause = Experiments(rodent_n).experiment_number(experiment_n).marquers.after_LF_HF_ratio(end);
            LF_HF_ratio_mean_experiments_final_pause = [LF_HF_ratio_mean_experiments_final_pause, LF_HF_ratio_experiments_final_pause];
    
        end
    end
    
    
    
    % 1. Definir una función interna para formatear "Media ± DE"
    formatear = @(datos) sprintf('%.2f ± %.2f', mean(datos), std(datos));
    
    % 2. Crear los strings formateados para cada fila
    filas_nombres = {'MNN (ms)'; 'SDNN (ms)'; 'RMSSD (ms)'; 'LF (ms^{2})'; 'HF (ms^{2})'; 'TP (ms^{2})'; 'LF/HF'};
    
    columna_baseline = {
        formatear(MNN_mean_experiments_baseline);
        formatear(SDNN_mean_experiments_baseline);
        formatear(RMSSD_mean_experiments_baseline);
        formatear(LF_mean_experiments_baseline);
        formatear(HF_mean_experiments_baseline);
        formatear(TP_mean_experiments_baseline);
        formatear(LF_HF_ratio_mean_experiments_baseline)
        
    };
    
    columna_pause = {
        formatear(MNN_mean_experiments_final_pause);
        formatear(SDNN_mean_experiments_final_pause);
        formatear(RMSSD_mean_experiments_final_pause);
        formatear(LF_mean_experiments_final_pause);
        formatear(HF_mean_experiments_final_pause);
        formatear(TP_mean_experiments_final_pause);
        formatear(LF_HF_ratio_mean_experiments_final_pause)
    };
    
    % 3. Construir la tabla final
    TablaComparativa = table(filas_nombres, columna_baseline, columna_pause, ...
        'VariableNames', {'Parametro', 'Baseline (B)', 'Final pause (P2)'});
    
    %%Como ver si son significativos los cambios
    variables = {'MNN','SDNN','RMSSD','LF','HF','TP','LF/HF'};
    
    baseline = {
        MNN_mean_experiments_baseline,
        SDNN_mean_experiments_baseline,
        RMSSD_mean_experiments_baseline,
        LF_mean_experiments_baseline,
        HF_mean_experiments_baseline,
        TP_mean_experiments_baseline,
        LF_HF_ratio_mean_experiments_baseline
    };
    
    pause = {
        MNN_mean_experiments_final_pause,
        SDNN_mean_experiments_final_pause,
        RMSSD_mean_experiments_final_pause,
        LF_mean_experiments_final_pause,
        HF_mean_experiments_final_pause,
        TP_mean_experiments_final_pause,
        LF_HF_ratio_mean_experiments_baseline
    };
    
    p_values = zeros(length(variables),1);
    
    for i = 1:length(variables)
        diff = pause{i} - baseline{i};
        
        if lillietest(diff) == 0
            [~,p] = ttest(baseline{i}, pause{i});
        else
            p = signrank(baseline{i}, pause{i});
        end
        
        p_values(i) = p;
    end
    
    
    TablaComparativa.P = p_values;
    
    signif_symbols = strings(6,1);
    
    for i = 1:7
        if p_values(i) < 0.001
            signif_symbols(i) = "**";
        elseif p_values(i) < 0.05
            signif_symbols(i) = "*";
        else
            signif_symbols(i) = "";
        end
    end
    
    TablaComparativa.Significance = signif_symbols;
    
    
    columna_pause_sig = columna_pause;
    
    for i = 1:6
        columna_pause_sig{i} = strcat(columna_pause{i}, " ", signif_symbols(i));
    end
    
    % TablaComparativa.kk = columna_pause_sig;
    
    % 4. Mostrar el resultado
    disp(TablaComparativa);
    
    HRV_parameters = {};
    HRV_parameters.parameters_names = filas_nombres;
    HRV_parameters.baseline_values = columna_baseline;
    HRV_parameters.end_values = columna_pause;
    HRV_parameters.p_values = p_values;
    
end