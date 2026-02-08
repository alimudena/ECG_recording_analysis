for m = 1:length(Database.mouse)
    for s = 1:length(Database.mouse(m).session)
        metrics = Database.mouse(m).session(s).metrics;
    end
end

HR_control = [];
HR_noncontrol = [];

for m = 1:length(Database.mouse)
    for s = 1:length(Database.mouse(m).session)

        if isempty(Database.mouse(m).session(s).metrics)
            continue
        end

        HR = Database.mouse(m).session(s).metrics.meanHR;

        if Database.mouse(m).isControl
            HR_control(end+1) = HR;
        else
            HR_noncontrol(end+1) = HR;
        end
    end
end

boxplot([HR_control, HR_noncontrol], ...
        [ones(size(HR_control)), 2*ones(size(HR_noncontrol))])
set(gca,'XTickLabel',{'Control','No control'})
ylabel('HR medio (ppm)')
