function ECG_visualization(signal, t, title_label)
    figure
    plot(t, signal);
    title(title_label);
    xlabel('Time (s)'); 
    ylabel('Amplitud');
end