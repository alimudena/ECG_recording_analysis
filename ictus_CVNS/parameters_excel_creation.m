disp('Creating excel with parameters');
rows = {};

for rodent = 1:length(Experiments)

    exps = Experiments(rodent).experiment_number;

    for e = 1:length(exps)

        M = exps(e).marquers;

        estadisticos = {
            'MNN', M.before_MNN, M.during_MNN, M.after_MNN;
            'SDNN', M.before_SDNN, M.during_SDNN, M.after_SDNN;
            'RMSSD', M.before_RMSSD, M.during_RMSSD, M.after_RMSSD;
            'LF', M.before_LF, M.during_LF, M.after_LF;
            'HF', M.before_HF, M.during_HF, M.after_HF;
            'TP', M.before_TP, M.during_TP, M.after_TP;
            'LF_HF', M.before_LF_HF_ratio, M.during_LF_HF_ratio, M.after_LF_HF_ratio;
        };

        for s = 1:size(estadisticos,1)

            nombre = estadisticos{s,1};

            before = estadisticos{s,2};
            during = estadisticos{s,3};
            after  = estadisticos{s,4};

            fila = {rodent,e,nombre};

            nStim = length(before);

            for k = 1:nStim

                fila{end+1} = before(k);
                fila{end+1} = during(k);
                fila{end+1} = after(k);

            end

            rows(end+1,:) = fila;

        end
    end
end

varNames = {'Raton','Sesion','Estadistico'};
maxStim = 0;

for rodent = 1:length(Experiments)

    exps = Experiments(rodent).experiment_number;

    for e = 1:length(exps)

        nStim = length(exps(e).marquers.before_MNN);

        maxStim = max(maxStim,nStim);

    end
end

for k = 0:maxStim-1

    varNames{end+1} = sprintf('PreStim_%d',k+1);
    varNames{end+1} = sprintf('Stim_%d',k+1);
    varNames{end+1} = sprintf('PostStim_%d',k+1);

end

T = cell2table(rows,...
    'VariableNames',varNames);

disp('Done');
