
function hist_ppm_in_window(t_ppm, ppm_RR, t_start, t_end, min_ppm, max_ppm, bins, stim_or_not)
% HIST_PPM_IN_WINDOW: Histograma entre 200 y 350 ppm con 40 bins.
%
% Inputs:
%   - t_ppm: tiempos de cada bpm (seg)
%   - ppm_RR: valores ppm para cada latido
%   - t_start: inicio del intervalo (seg)
%   - t_end: fin del intervalo (seg)

    % Selección del intervalo temporal
    idx = t_ppm >= t_start & t_ppm <= t_end;
    ppm_segment = ppm_RR(idx);

    if isempty(ppm_segment)
        disp('No hay latidos en este intervalo');
        return;
    end

    % Bins fijos entre 200 y 350
    bin_edges = linspace(min_ppm, max_ppm, bins);  % 40 bins → 41 edges

    % Histograma
    figure;
    histogram(ppm_segment, bin_edges, 'FaceColor',[0 0.4 0.8]);
    grid on;
    xlabel('PPM');
    ylabel('Frecuencia');
    title(['Histograma PPM entre ', num2str(t_start), ' y ', num2str(t_end), ' s ', stim_or_not]);
    xlim([min_ppm max_ppm]);
end
