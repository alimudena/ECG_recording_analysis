
function [time_intervals, bpm_values_raw] = BPM_calculation(segment_duration, fs, ecg_signal, locs_raw)
    samples_per_segment = segment_duration * fs;
    num_segments = floor(length(ecg_signal) / samples_per_segment);

    bpm_values_raw = zeros(1, num_segments);
    time_intervals = (0:num_segments-1) * segment_duration;
    
    for i = 1:num_segments
        segment_start = (i-1) * samples_per_segment + 1;
        segment_end = segment_start + samples_per_segment - 1;
        
        % Contar los picos en este segmento
        num_beats_raw = sum(locs_raw >= segment_start & locs_raw <= segment_end);
        
        % Convertir a BPM
        bpm_values_raw(i) = (num_beats_raw / segment_duration) * 60;
    end
end
