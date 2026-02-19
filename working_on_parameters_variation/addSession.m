function Database = addSession(Database, mouseID, isControl, sessionData)

% --- CASO 1: no hay ningún ratón todavía ---
if isempty(Database.mouse)
    idx = 1;
    Database.mouse(idx).id = mouseID;
    Database.mouse(idx).isControl = isControl;
    Database.mouse(idx).session = [];
else
    % --- CASO 2: ya hay ratones, buscar si existe ---
    ids = {Database.mouse.id};
    idx = find(strcmp(ids, mouseID), 1);

    % Si no existe, crear nuevo ratón
    if isempty(idx)
        idx = length(Database.mouse) + 1;
        Database.mouse(idx).id = mouseID;
        Database.mouse(idx).isControl = isControl;
        Database.mouse(idx).session = Database.mouse(idx).sessionIdx;
    end
end

% --- Añadir nueva sesión ---
s = length(Database.mouse(idx).session) + 1;

Database.mouse(idx).session(s).date  = sessionData.date;
Database.mouse(idx).session(s).type = sessionData.type;
Database.mouse(idx).session(s).stim = sessionData.stim;
Database.mouse(idx).session(s).rest = sessionData.rest;
Database.mouse(idx).session(s).notes = sessionData.notes;
Database.mouse(idx).session(s).sessionIdx = sessionData.sessionIdx;
end