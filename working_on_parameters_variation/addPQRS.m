function Database = addPQRS(Database, mouseID, sessionIdx, pqrsData)

idx = find(strcmp({Database.mouse.id}, mouseID));

Database.mouse(idx).session(sessionIdx).pqrs = pqrsData;

end
