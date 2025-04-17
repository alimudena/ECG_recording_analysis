function [time_intervals, bpm_values_raw] = BPM_calculation_overlap(segment_duration, overlap_duration, fs, ecg_signal, locs_raw)
    % Cálculo del desplazamiento entre ventanas (en muestras)
    hop_size = (segment_duration - overlap_duration) * fs;
    samples_per_segment = segment_duration * fs;

    % Calcular el número total de ventanas posibles
    num_segments = floor((length(ecg_signal) - samples_per_segment) / hop_size) + 1;

    bpm_values_raw = zeros(1, num_segments);
    time_intervals = zeros(1, num_segments);
    
    for i = 1:num_segments
        segment_start = round((i - 1) * hop_size) + 1;
        segment_end = segment_start + samples_per_segment - 1;

        % Guardar el tiempo correspondiente al inicio del segmento
        time_intervals(i) = (segment_start - 1) / fs;

        % Contar los picos en este segmento
        num_beats_raw = sum(locs_raw >= segment_start & locs_raw <= segment_end);

        % Calcular BPM
        bpm_values_raw(i) = (num_beats_raw / segment_duration) * 60;
    end
end
