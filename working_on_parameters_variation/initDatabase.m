function Database = initDatabase(filename)

if exist(filename, 'file')
    load(filename, 'Database');
    disp('Base de datos cargada');
else
    Database = struct('mouse', []);
    disp('Base de datos creada');
end

end
