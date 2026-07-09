disp('Start graphing and saving all experiments results together');

Resultados = table();

%% MNN


S = [];
P = [];
for rodent_n = 1:length(Experiments)
    for experiment_n = 1:length(Experiments(rodent_n).experiment_number)
        B = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_MNN(1);
    
        S = [S, (Experiments(rodent_n).experiment_number(experiment_n).marquers.during_MNN(:)-B)/B*100];
        P = [P, (Experiments(rodent_n).experiment_number(experiment_n).marquers.after_MNN(:)-B)/B*100];
    end
end

S1 = S(1, :);
P1 = P(1, :);

S2 = S(2, :);
P2 = P(2, :);

S3 = S(3, :);
P3 = P(3, :);

S4 = S(4, :);
P4 = P(4, :);

S5 = S(5, :);
P5 = P(5, :);

% 1. Preparar los datos para el gráfico (promedios de todos los experimentos)
% La Fase B (Baseline) es siempre 0% por definición en tu cálculo
mean_S1 = mean(S1);
mean_P1 = mean(P1);

mean_S2 = mean(S2);
mean_P2 = mean(P2);

mean_S3 = mean(S3);
mean_P3 = mean(P3);

mean_S4 = mean(S4);
mean_P4 = mean(P4);

mean_S5 = mean(S5);
mean_P5 = mean(P5);

mean_data = [mean_S1, mean_P1, mean_S2, mean_P2, mean_S3, mean_P3, mean_S4, mean_P4, mean_S5, mean_P5];

% 2. Calcular el SEM (Error estándar de la media)
% El SEM de B es 0. Para S y P es: Desviación estándar / raíz(N)
sem_S1 = std(S1) / sqrt(numel(S1));
sem_P1 = std(P1) / sqrt(numel(P1));

sem_S2 = std(S2) / sqrt(numel(S2));
sem_P2 = std(P2) / sqrt(numel(P2));

sem_S3 = std(S3) / sqrt(numel(S3));
sem_P3 = std(P3) / sqrt(numel(P3));

sem_S4 = std(S4) / sqrt(numel(S4));
sem_P4 = std(P4) / sqrt(numel(P4));

sem_S5 = std(S5) / sqrt(numel(S5));
sem_P5 = std(P5) / sqrt(numel(P5));

sem_data = [sem_S1, sem_P1, sem_S2, sem_P2, sem_S3, sem_P3, sem_S4, sem_P4, sem_S5, sem_P5];


figure('Color', 'w');
hold on;
% Dibujar barras (Gris claro como en el paper)
b = bar(1:10, mean_data, 'FaceColor', [0.85 0.85 0.85], 'EdgeColor', 'k', 'LineWidth', 0.2);

% Añadir barras de error (SEM)
errorbar(1:10, mean_data, sem_data, 'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 10);

% 4. Estética estilo Szeles et al. 2021
ylabel('\Delta RMSSD [%]', 'FontSize', 12, 'FontWeight', 'bold');
set(gca, 'XTick', 1:10, 'XTickLabel', {'S1', 'P1', 'S2', 'P2', 'S3', 'P3', 'S4', 'P4', 'S5', 'P5'}, 'FontSize', 11);
title('Efecto de la estimulación en MNN');

T = cell2table([{'MNN - Media'}, num2cell(mean_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];

T = cell2table([{'MNN - DesvTip'}, num2cell(sem_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];

%% RMSSD


S = [];
P = [];
for rodent_n = 1:length(Experiments)
    for experiment_n = 1:length(Experiments(rodent_n).experiment_number)
        B = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_RMSSD(1);
    
        S = [S, (Experiments(rodent_n).experiment_number(experiment_n).marquers.during_RMSSD(:)-B)/B*100];
        P = [P, (Experiments(rodent_n).experiment_number(experiment_n).marquers.after_RMSSD(:)-B)/B*100];
    end
end

S1 = S(1, :);
P1 = P(1, :);

S2 = S(2, :);
P2 = P(2, :);

S3 = S(3, :);
P3 = P(3, :);

S4 = S(4, :);
P4 = P(4, :);

S5 = S(5, :);
P5 = P(5, :);

% 1. Preparar los datos para el gráfico (promedios de todos los experimentos)
% La Fase B (Baseline) es siempre 0% por definición en tu cálculo
mean_S1 = mean(S1);
mean_P1 = mean(P1);

mean_S2 = mean(S2);
mean_P2 = mean(P2);

mean_S3 = mean(S3);
mean_P3 = mean(P3);

mean_S4 = mean(S4);
mean_P4 = mean(P4);

mean_S5 = mean(S5);
mean_P5 = mean(P5);

mean_data = [mean_S1, mean_P1, mean_S2, mean_P2, mean_S3, mean_P3, mean_S4, mean_P4, mean_S5, mean_P5];

% 2. Calcular el SEM (Error estándar de la media)
% El SEM de B es 0. Para S y P es: Desviación estándar / raíz(N)
sem_S1 = std(S1) / sqrt(numel(S1));
sem_P1 = std(P1) / sqrt(numel(P1));

sem_S2 = std(S2) / sqrt(numel(S2));
sem_P2 = std(P2) / sqrt(numel(P2));

sem_S3 = std(S3) / sqrt(numel(S3));
sem_P3 = std(P3) / sqrt(numel(P3));

sem_S4 = std(S4) / sqrt(numel(S4));
sem_P4 = std(P4) / sqrt(numel(P4));

sem_S5 = std(S5) / sqrt(numel(S5));
sem_P5 = std(P5) / sqrt(numel(P5));

sem_data = [sem_S1, sem_P1, sem_S2, sem_P2, sem_S3, sem_P3, sem_S4, sem_P4, sem_S5, sem_P5];


figure('Color', 'w');
hold on;
% Dibujar barras (Gris claro como en el paper)
b = bar(1:10, mean_data, 'FaceColor', [0.85 0.85 0.85], 'EdgeColor', 'k', 'LineWidth', 0.2);

% Añadir barras de error (SEM)
errorbar(1:10, mean_data, sem_data, 'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 10);

% 4. Estética estilo Szeles et al. 2021
ylabel('\Delta RMSSD [%]', 'FontSize', 12, 'FontWeight', 'bold');
set(gca, 'XTick', 1:10, 'XTickLabel', {'S1', 'P1', 'S2', 'P2', 'S3', 'P3', 'S4', 'P4', 'S5', 'P5'}, 'FontSize', 11);
title('Efecto de la estimulación en RMSSD');


T = cell2table([{'RMSSD - Media'}, num2cell(mean_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];

T = cell2table([{'RMSSD - DesvTip'}, num2cell(sem_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];
%% SDNN
S = [];
P = [];
for rodent_n = 1:length(Experiments)
    for experiment_n = 1:length(Experiments(rodent_n).experiment_number)
        B = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_SDNN(1);
    
        S = [S, (Experiments(rodent_n).experiment_number(experiment_n).marquers.during_SDNN(:)-B)/B*100];
        P = [P, (Experiments(rodent_n).experiment_number(experiment_n).marquers.after_SDNN(:)-B)/B*100];
    end
end

S1 = S(1, :);
P1 = P(1, :);

S2 = S(2, :);
P2 = P(2, :);

S3 = S(3, :);
P3 = P(3, :);

S4 = S(4, :);
P4 = P(4, :);

S5 = S(5, :);
P5 = P(5, :);

% 1. Preparar los datos para el gráfico (promedios de todos los experimentos)
% La Fase B (Baseline) es siempre 0% por definición en tu cálculo
mean_S1 = mean(S1);
mean_P1 = mean(P1);

mean_S2 = mean(S2);
mean_P2 = mean(P2);

mean_S3 = mean(S3);
mean_P3 = mean(P3);

mean_S4 = mean(S4);
mean_P4 = mean(P4);

mean_S5 = mean(S5);
mean_P5 = mean(P5);

mean_data = [mean_S1, mean_P1, mean_S2, mean_P2, mean_S3, mean_P3, mean_S4, mean_P4, mean_S5, mean_P5];

% 2. Calcular el SEM (Error estándar de la media)
% El SEM de B es 0. Para S y P es: Desviación estándar / raíz(N)
sem_S1 = std(S1) / sqrt(numel(S1));
sem_P1 = std(P1) / sqrt(numel(P1));

sem_S2 = std(S2) / sqrt(numel(S2));
sem_P2 = std(P2) / sqrt(numel(P2));

sem_S3 = std(S3) / sqrt(numel(S3));
sem_P3 = std(P3) / sqrt(numel(P3));

sem_S4 = std(S4) / sqrt(numel(S4));
sem_P4 = std(P4) / sqrt(numel(P4));

sem_S5 = std(S5) / sqrt(numel(S5));
sem_P5 = std(P5) / sqrt(numel(P5));

sem_data = [sem_S1, sem_P1, sem_S2, sem_P2, sem_S3, sem_P3, sem_S4, sem_P4, sem_S5, sem_P5];


figure('Color', 'w');
hold on;
% Dibujar barras (Gris claro como en el paper)
b = bar(1:10, mean_data, 'FaceColor', [0.85 0.85 0.85], 'EdgeColor', 'k', 'LineWidth', 0.2);

% Añadir barras de error (SEM)
errorbar(1:10, mean_data, sem_data, 'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 10);

% 4. Estética estilo Szeles et al. 2021
ylabel('\Delta SDNN [%]', 'FontSize', 12, 'FontWeight', 'bold');
set(gca, 'XTick', 1:10, 'XTickLabel', {'S1', 'P1', 'S2', 'P2', 'S3', 'P3', 'S4', 'P4', 'S5', 'P5'}, 'FontSize', 11);
title('Efecto de la estimulación en SDNN');

T = cell2table([{'SDNN - Media'}, num2cell(mean_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];

T = cell2table([{'SDNN - DesvTip'}, num2cell(sem_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];

%% LF
S = [];
P = [];
for rodent_n = 1:length(Experiments)
    for experiment_n = 1:length(Experiments(rodent_n).experiment_number)
        B = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_LF(1);
    
        S = [S, (Experiments(rodent_n).experiment_number(experiment_n).marquers.during_LF(:)-B)/B*100];
        P = [P, (Experiments(rodent_n).experiment_number(experiment_n).marquers.after_LF(:)-B)/B*100];
    end
end

S1 = S(1, :);
P1 = P(1, :);

S2 = S(2, :);
P2 = P(2, :);

S3 = S(3, :);
P3 = P(3, :);

S4 = S(4, :);
P4 = P(4, :);

S5 = S(5, :);
P5 = P(5, :);

% 1. Preparar los datos para el gráfico (promedios de todos los experimentos)
% La Fase B (Baseline) es siempre 0% por definición en tu cálculo
mean_S1 = mean(S1);
mean_P1 = mean(P1);

mean_S2 = mean(S2);
mean_P2 = mean(P2);

mean_S3 = mean(S3);
mean_P3 = mean(P3);

mean_S4 = mean(S4);
mean_P4 = mean(P4);

mean_S5 = mean(S5);
mean_P5 = mean(P5);

mean_data = [mean_S1, mean_P1, mean_S2, mean_P2, mean_S3, mean_P3, mean_S4, mean_P4, mean_S5, mean_P5];

% 2. Calcular el SEM (Error estándar de la media)
% El SEM de B es 0. Para S y P es: Desviación estándar / raíz(N)
sem_S1 = std(S1) / sqrt(numel(S1));
sem_P1 = std(P1) / sqrt(numel(P1));

sem_S2 = std(S2) / sqrt(numel(S2));
sem_P2 = std(P2) / sqrt(numel(P2));

sem_S3 = std(S3) / sqrt(numel(S3));
sem_P3 = std(P3) / sqrt(numel(P3));

sem_S4 = std(S4) / sqrt(numel(S4));
sem_P4 = std(P4) / sqrt(numel(P4));

sem_S5 = std(S5) / sqrt(numel(S5));
sem_P5 = std(P5) / sqrt(numel(P5));

sem_data = [sem_S1, sem_P1, sem_S2, sem_P2, sem_S3, sem_P3, sem_S4, sem_P4, sem_S5, sem_P5];


figure('Color', 'w');
hold on;
% Dibujar barras (Gris claro como en el paper)
b = bar(1:10, mean_data, 'FaceColor', [0.85 0.85 0.85], 'EdgeColor', 'k', 'LineWidth', 0.2);

% Añadir barras de error (SEM)
errorbar(1:10, mean_data, sem_data, 'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 10);

% 4. Estética estilo Szeles et al. 2021
ylabel('\Delta LF [%]', 'FontSize', 12, 'FontWeight', 'bold');
set(gca, 'XTick', 1:10, 'XTickLabel', {'S1', 'P1', 'S2', 'P2', 'S3', 'P3', 'S4', 'P4', 'S5', 'P5'}, 'FontSize', 11);
title('Efecto de la estimulación en LF');

T = cell2table([{'\Delta LF - Media'}, num2cell(mean_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];

T = cell2table([{'\Delta LF - DesvTip'}, num2cell(sem_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];
%% HF
S = [];
P = [];
for rodent_n = 1:length(Experiments)
    for experiment_n = 1:length(Experiments(rodent_n).experiment_number)
        B = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_HF(1);
    
        S = [S, (Experiments(rodent_n).experiment_number(experiment_n).marquers.during_HF(:)-B)/B*100];
        P = [P, (Experiments(rodent_n).experiment_number(experiment_n).marquers.after_HF(:)-B)/B*100];
    end
end

S1 = S(1, :);
P1 = P(1, :);

S2 = S(2, :);
P2 = P(2, :);

S3 = S(3, :);
P3 = P(3, :);

S4 = S(4, :);
P4 = P(4, :);

S5 = S(5, :);
P5 = P(5, :);

% 1. Preparar los datos para el gráfico (promedios de todos los experimentos)
% La Fase B (Baseline) es siempre 0% por definición en tu cálculo
mean_S1 = mean(S1);
mean_P1 = mean(P1);

mean_S2 = mean(S2);
mean_P2 = mean(P2);

mean_S3 = mean(S3);
mean_P3 = mean(P3);

mean_S4 = mean(S4);
mean_P4 = mean(P4);

mean_S5 = mean(S5);
mean_P5 = mean(P5);

mean_data = [mean_S1, mean_P1, mean_S2, mean_P2, mean_S3, mean_P3, mean_S4, mean_P4, mean_S5, mean_P5];

% 2. Calcular el SEM (Error estándar de la media)
% El SEM de B es 0. Para S y P es: Desviación estándar / raíz(N)
sem_S1 = std(S1) / sqrt(numel(S1));
sem_P1 = std(P1) / sqrt(numel(P1));

sem_S2 = std(S2) / sqrt(numel(S2));
sem_P2 = std(P2) / sqrt(numel(P2));

sem_S3 = std(S3) / sqrt(numel(S3));
sem_P3 = std(P3) / sqrt(numel(P3));

sem_S4 = std(S4) / sqrt(numel(S4));
sem_P4 = std(P4) / sqrt(numel(P4));

sem_S5 = std(S5) / sqrt(numel(S5));
sem_P5 = std(P5) / sqrt(numel(P5));

sem_data = [sem_S1, sem_P1, sem_S2, sem_P2, sem_S3, sem_P3, sem_S4, sem_P4, sem_S5, sem_P5];


figure('Color', 'w');
hold on;
% Dibujar barras (Gris claro como en el paper)
b = bar(1:10, mean_data, 'FaceColor', [0.85 0.85 0.85], 'EdgeColor', 'k', 'LineWidth', 0.2);

% Añadir barras de error (SEM)
errorbar(1:10, mean_data, sem_data, 'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 10);

% 4. Estética estilo Szeles et al. 2021
ylabel('\Delta HF [%]', 'FontSize', 12, 'FontWeight', 'bold');
set(gca, 'XTick', 1:10, 'XTickLabel', {'S1', 'P1', 'S2', 'P2', 'S3', 'P3', 'S4', 'P4', 'S5', 'P5'}, 'FontSize', 11);
title('Efecto de la estimulación en HF');

T = cell2table([{'\Delta HF - Media'}, num2cell(mean_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];

T = cell2table([{'\Delta HF - DesvTip'}, num2cell(sem_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];
%% TP_ratio
S = [];
P = [];
for rodent_n = 1:length(Experiments)
    for experiment_n = 1:length(Experiments(rodent_n).experiment_number)
        B = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_TP(1);
    
        S = [S, (Experiments(rodent_n).experiment_number(experiment_n).marquers.during_TP(:)-B)/B*100];
        P = [P, (Experiments(rodent_n).experiment_number(experiment_n).marquers.after_TP(:)-B)/B*100];
    end
end

S1 = S(1, :);
P1 = P(1, :);

S2 = S(2, :);
P2 = P(2, :);

S3 = S(3, :);
P3 = P(3, :);

S4 = S(4, :);
P4 = P(4, :);

S5 = S(5, :);
P5 = P(5, :);

% 1. Preparar los datos para el gráfico (promedios de todos los experimentos)
% La Fase B (Baseline) es siempre 0% por definición en tu cálculo
mean_S1 = mean(S1);
mean_P1 = mean(P1);

mean_S2 = mean(S2);
mean_P2 = mean(P2);

mean_S3 = mean(S3);
mean_P3 = mean(P3);

mean_S4 = mean(S4);
mean_P4 = mean(P4);

mean_S5 = mean(S5);
mean_P5 = mean(P5);

mean_data = [mean_S1, mean_P1, mean_S2, mean_P2, mean_S3, mean_P3, mean_S4, mean_P4, mean_S5, mean_P5];

% 2. Calcular el SEM (Error estándar de la media)
% El SEM de B es 0. Para S y P es: Desviación estándar / raíz(N)
sem_S1 = std(S1) / sqrt(numel(S1));
sem_P1 = std(P1) / sqrt(numel(P1));

sem_S2 = std(S2) / sqrt(numel(S2));
sem_P2 = std(P2) / sqrt(numel(P2));

sem_S3 = std(S3) / sqrt(numel(S3));
sem_P3 = std(P3) / sqrt(numel(P3));

sem_S4 = std(S4) / sqrt(numel(S4));
sem_P4 = std(P4) / sqrt(numel(P4));

sem_S5 = std(S5) / sqrt(numel(S5));
sem_P5 = std(P5) / sqrt(numel(P5));

sem_data = [sem_S1, sem_P1, sem_S2, sem_P2, sem_S3, sem_P3, sem_S4, sem_P4, sem_S5, sem_P5];


figure('Color', 'w');
hold on;
% Dibujar barras (Gris claro como en el paper)
b = bar(1:10, mean_data, 'FaceColor', [0.85 0.85 0.85], 'EdgeColor', 'k', 'LineWidth', 0.2);

% Añadir barras de error (SEM)
errorbar(1:10, mean_data, sem_data, 'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 10);

% 4. Estética estilo Szeles et al. 2021
ylabel('\Delta TP[%]', 'FontSize', 12, 'FontWeight', 'bold');
set(gca, 'XTick', 1:10, 'XTickLabel', {'S1', 'P1', 'S2', 'P2', 'S3', 'P3', 'S4', 'P4', 'S5', 'P5'}, 'FontSize', 11);
title('Efecto de la estimulación en TP');



T = cell2table([{'\Delta TP - Media'}, num2cell(mean_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];

T = cell2table([{'\Delta TP - DesvTip'}, num2cell(sem_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];
%% LF_HF_ratio
S = [];
P = [];
for rodent_n = 1:length(Experiments)
    for experiment_n = 1:length(Experiments(rodent_n).experiment_number)
        B = Experiments(rodent_n).experiment_number(experiment_n).marquers.before_LF_HF_ratio(1);
    
        S = [S, (Experiments(rodent_n).experiment_number(experiment_n).marquers.during_LF_HF_ratio(:)-B)/B*100];
        P = [P, (Experiments(rodent_n).experiment_number(experiment_n).marquers.after_LF_HF_ratio(:)-B)/B*100];
    end
end

S1 = S(1, :);
P1 = P(1, :);

S2 = S(2, :);
P2 = P(2, :);

S3 = S(3, :);
P3 = P(3, :);

S4 = S(4, :);
P4 = P(4, :);

S5 = S(5, :);
P5 = P(5, :);

% 1. Preparar los datos para el gráfico (promedios de todos los experimentos)
% La Fase B (Baseline) es siempre 0% por definición en tu cálculo
mean_S1 = mean(S1);
mean_P1 = mean(P1);

mean_S2 = mean(S2);
mean_P2 = mean(P2);

mean_S3 = mean(S3);
mean_P3 = mean(P3);

mean_S4 = mean(S4);
mean_P4 = mean(P4);

mean_S5 = mean(S5);
mean_P5 = mean(P5);

mean_data = [mean_S1, mean_P1, mean_S2, mean_P2, mean_S3, mean_P3, mean_S4, mean_P4, mean_S5, mean_P5];

% 2. Calcular el SEM (Error estándar de la media)
% El SEM de B es 0. Para S y P es: Desviación estándar / raíz(N)
sem_S1 = std(S1) / sqrt(numel(S1));
sem_P1 = std(P1) / sqrt(numel(P1));

sem_S2 = std(S2) / sqrt(numel(S2));
sem_P2 = std(P2) / sqrt(numel(P2));

sem_S3 = std(S3) / sqrt(numel(S3));
sem_P3 = std(P3) / sqrt(numel(P3));

sem_S4 = std(S4) / sqrt(numel(S4));
sem_P4 = std(P4) / sqrt(numel(P4));

sem_S5 = std(S5) / sqrt(numel(S5));
sem_P5 = std(P5) / sqrt(numel(P5));

sem_data = [sem_S1, sem_P1, sem_S2, sem_P2, sem_S3, sem_P3, sem_S4, sem_P4, sem_S5, sem_P5];


figure('Color', 'w');
hold on;
% Dibujar barras (Gris claro como en el paper)
b = bar(1:10, mean_data, 'FaceColor', [0.85 0.85 0.85], 'EdgeColor', 'k', 'LineWidth', 0.2);

% Añadir barras de error (SEM)
errorbar(1:10, mean_data, sem_data, 'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 10);

% 4. Estética estilo Szeles et al. 2021
ylabel('\Delta {LF/HF}[%]', 'FontSize', 12, 'FontWeight', 'bold');
set(gca, 'XTick', 1:10, 'XTickLabel', {'S1', 'P1', 'S2', 'P2', 'S3', 'P3', 'S4', 'P4', 'S5', 'P5'}, 'FontSize', 11);
title('Efecto de la estimulación en LF/HF');


T = cell2table([{'\Delta {LF/HF} - Media'}, num2cell(mean_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];

T = cell2table([{'\Delta {LF/HF} - DesvTip'}, num2cell(sem_data)], ...
    'VariableNames', {'Parametro','S1','P1','S2','P2','S3','P3','S4','P4','S5','P5'});

Resultados = [Resultados; T];

disp('Done');