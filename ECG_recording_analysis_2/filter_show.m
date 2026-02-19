function filter_show(fs, Q)

    wo = 50/(fs/2);
    bw = wo/Q;
    [b_notch, a_notch] = iirnotch(wo, bw);
    
    fig = figure;
    freqz(b_notch, a_notch, 4096, fs);
    title('50 Hz Notch filter');
    
    ax = findall(fig, 'Type', 'axes');
    arrayfun(@(a) xlim(a, [0 0.2]), ax);


end