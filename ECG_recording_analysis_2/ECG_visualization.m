function ECG_visualization(signal, t, title_label)
    figure
    plot(t, signal);
    title(title_label, 'Interpreter','none');
    xlabel('Time (s)'); 
    ylabel('Amplitud');
    xlim([0, max(t)])
end