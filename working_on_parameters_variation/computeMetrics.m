function Database = computeMetrics(Database, mouseID, sessionIdx)

idx = find(strcmp({Database.mouse.id}, mouseID));
R = Database.mouse(idx).session(sessionIdx).pqrs.R_times;

RR = diff(R);
HR = 60 ./ RR;

Database.mouse(idx).session(sessionIdx).metrics.meanHR = mean(HR);
Database.mouse(idx).session(sessionIdx).metrics.SDNN   = std(RR);

end
