function verificar_entorno_python()
    clc
    disp("🔎 Verificando configuración de Python para uso desde system()...")

    % 1. Verificar si 'python' está en el PATH
    [status, output] = system('where python');
    
    if status ~= 0
        disp("❌ No se encontró 'python' en el PATH.");
        disp("   👉 Asegúrate de que Python esté instalado y su ruta esté en las variables de entorno.");
        return
    end
    
    paths = splitlines(strtrim(output));
    disp("✅ Python encontrado en el PATH en las siguientes ubicaciones:");
    disp(paths)
    
    % 2. Detectar si alguno es un alias de Microsoft Store
    es_store_alias = any(contains(paths, 'WindowsApps', 'IgnoreCase', true));
    
    if es_store_alias
        disp("⚠️ Se detectó un alias de Microsoft Store. Esto puede causar errores como:");
        disp("   'no se encontró Python; ejecutar sin argumentos para instalar desde Microsoft Store...'")
        disp("   👉 Ve a Configuración > Aplicaciones > Alias de ejecución y desactiva los alias de python.exe y python3.exe.")
        return
    end

    % 3. Obtener versión de Python
    [status2, ver_output] = system('python --version');
    if status2 == 0
        disp(['🧪 Versión de Python detectada: ' strtrim(ver_output)])
        if contains(ver_output, '3.10')
            disp("✅ Versión 3.10 compatible con MATLAB.")
        else
            disp("⚠️ Python funciona, pero no es versión 3.10. MATLAB 2022/2024 funciona mejor con 3.10.")
        end
    else
        disp("❌ No se pudo obtener la versión de Python.")
    end

    disp("🎉 Listo para usar system('python ...') si no se detectaron errores arriba.")
end
