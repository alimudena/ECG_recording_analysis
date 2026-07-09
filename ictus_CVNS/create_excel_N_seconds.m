
filename = excelFile;
T = table();
% Recorrer experimentos
for exp = 1:length(Experiments(rodent).experiment_number)



    marquers = Experiments(rodent).experiment_number(exp).marquers;

    % Tabla del animal
    Trodent = table();

    % Añadir identificador del animal (opcional)
    % Si no lo quieres, elimina estas dos líneas.
    N = size(marquers.(vars{1}),2);
    Trodent.experiment = repmat(exp,N,1);
    Trodent.sample = [1:N]';

    %Recorrer variables
    for v = 1:numel(vars)

        data = marquers.(vars{v});   % 5 x N

        % Pasar a N x 5
        % Verifica si la matriz NO tiene 5 columnas (es decir, no es Nx5)
        data = data.';


        % Crear nombres de columnas
        names = strcat(vars{v}, "_", string(1:size(data, 2)));

        % Añadir a la tabla
        if (isscalar(data))
            Taux = array2table(data, 'VariableNames', cellstr(names(1)));
        else
            Taux = array2table(data,'VariableNames', cellstr(names));

        end

        Trodent = [Trodent Taux];

    end

    % AÃƒÂ±adir este animal a la tabla global
    T = [T; Trodent];




end

% Escribir hoja del experimento
writetable(T,filename,'Sheet',sprintf('Experiment_%d',exp));