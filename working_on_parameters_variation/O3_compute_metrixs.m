R_times = [0.12 0.35 0.59 0.83];
P_times = [0.08 0.31 0.55 0.79];
Q_times = [0.10 0.33 0.57 0.81];
S_times = [0.14 0.37 0.61 0.85];
J_times = [0.16 0.39 0.63 0.87];
pqrsData.R_times = R_times;
pqrsData.P_times = P_times;
pqrsData.Q_times = Q_times;
pqrsData.S_times = S_times;
pqrsData.J_times = J_times;

Database = addPQRS(Database,'mouse01',1,pqrsData);

Database = computeMetrics(Database,'mouse01',1);

