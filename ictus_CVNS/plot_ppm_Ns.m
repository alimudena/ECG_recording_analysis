function plot_ppm_Ns(Experiments, rodent, experiment_number, stim_number)
    arguments
        Experiments
        rodent (1,1) double
        experiment_number (1,1) double
        stim_number (1,1) double = 0
    end

    experiment = Experiments(rodent).experiment_number(experiment_number);

    if ~isfield(experiment, 'marquers') || ...
       ~isfield(experiment.marquers, 'before_PPM_Ns') || ...
       ~isfield(experiment.marquers, 'during_PPM_Ns') || ...
       ~isfield(experiment.marquers, 'after_PPM_Ns')
        error('No se encontraron los campos before/during/after_PPM_Ns en la estructura.');
    end

    ppm_before = experiment.marquers.before_PPM_Ns;
    ppm_during = experiment.marquers.during_PPM_Ns;
    ppm_after = experiment.marquers.after_PPM_Ns;

    t_before = experiment.marquers.before_PPM_Ns_t;
    t_during = experiment.marquers.during_PPM_Ns_t;
    t_after = experiment.marquers.after_PPM_Ns_t;

    n_stims = length(ppm_before);

    if stim_number == 0
        figure('Color', 'w');
        tl = tiledlayout(n_stims, 1, 'TileSpacing', 'compact', 'Padding', 'compact');
        title(tl, sprintf('PPM cada N s - Rodent %d - Exp %d', rodent, experiment_number));

        for k = 1:n_stims
            nexttile;
            plot_one_stim(t_before{k}, ppm_before{k}, t_during{k}, ppm_during{k}, t_after{k}, ppm_after{k}, k);
        end
    else
        if stim_number < 1 || stim_number > n_stims
            error('stim_number fuera de rango. Debe estar entre 1 y %d, o 0 para todas.', n_stims);
        end

        figure('Color', 'w');
        plot_one_stim( ...
            t_before{stim_number}, ppm_before{stim_number}, ...
            t_during{stim_number}, ppm_during{stim_number}, ...
            t_after{stim_number}, ppm_after{stim_number}, ...
            stim_number);
        title(sprintf('PPM cada N s - Rodent %d - Exp %d - Stim %d', ...
            rodent, experiment_number, stim_number));
    end
end

function plot_one_stim(t_before, ppm_before, t_during, ppm_during, t_after, ppm_after, stim_id)
    hold on;

    if ~isempty(t_before)
        plot(t_before, ppm_before, '-o', 'LineWidth', 1.1, 'Color', [0.20 0.55 0.20], 'DisplayName', 'Antes');
    end
    if ~isempty(t_during)
        plot(t_during, ppm_during, '-o', 'LineWidth', 1.1, 'Color', [0.85 0.33 0.10], 'DisplayName', 'Durante');
    end
    if ~isempty(t_after)
        plot(t_after, ppm_after, '-o', 'LineWidth', 1.1, 'Color', [0.00 0.45 0.74], 'DisplayName', 'Despues');
    end

    if ~isempty(t_during)
        xline(t_during(1), '--', 'Inicio stim', 'LabelVerticalAlignment', 'middle');
        xline(t_during(end), '--', 'Fin stim', 'LabelVerticalAlignment', 'middle');
    end

    xlabel('Tiempo [s]');
    ylabel('PPM');
    title(sprintf('Estimulo %d', stim_id));
    grid on;
    % legend('Location', 'best');
    hold off;
end