function [ppm_before, ppm_during, ppm_after, t_before, t_during, t_after] = calculate_ppm_windows(t, start_idx, end_idx, R_idx, studied_intervals_sec, window_sec)
    if nargin < 6 || isempty(window_sec)
        window_sec = 10;
    end

    fs = 1 / median(diff(t));
    samples_per_window = round(window_sec * fs);
    n_stims = length(start_idx);

    ppm_before = cell(1, n_stims);
    ppm_during = cell(1, n_stims);
    ppm_after = cell(1, n_stims);
    t_before = cell(1, n_stims);
    t_during = cell(1, n_stims);
    t_after = cell(1, n_stims);

    for k = 1:n_stims
        before_start = max(1, start_idx(k) - round(studied_intervals_sec * fs));
        before_end = start_idx(k);

        during_start = start_idx(k);
        during_end = end_idx(k);

        after_start = end_idx(k);
        after_end = min(length(t), end_idx(k) + round(studied_intervals_sec * fs));

        [ppm_before{k}, t_before{k}] = compute_ppm_no_overlap(before_start, before_end, R_idx, t, samples_per_window, window_sec);
        [ppm_during{k}, t_during{k}] = compute_ppm_no_overlap(during_start, during_end, R_idx, t, samples_per_window, window_sec);
        [ppm_after{k}, t_after{k}] = compute_ppm_no_overlap(after_start, after_end, R_idx, t, samples_per_window, window_sec);
    end
end

function [ppm_values, t_centers] = compute_ppm_no_overlap(seg_start, seg_end, R_idx, t, samples_per_window, window_sec)
    n_samples = seg_end - seg_start;
    n_windows = floor(n_samples / samples_per_window);

    ppm_values = nan(1, n_windows);
    t_centers = nan(1, n_windows);

    for w = 1:n_windows
        w_start = seg_start + (w - 1) * samples_per_window;
        w_stop = w_start + samples_per_window;

        % Ventanas semiabiertas [inicio, fin) para evitar solapes en bordes.
        beats_in_window = sum(R_idx >= w_start & R_idx < w_stop);
        ppm_values(w) = beats_in_window * 60 / window_sec;

        center_idx = round((w_start + w_stop - 1) / 2);
        center_idx = min(max(center_idx, 1), length(t));
        t_centers(w) = t(center_idx);
    end
end