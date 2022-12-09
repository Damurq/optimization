clear all;
selection = menu('Seleccione la opción',...
    'Búsqueda lineal',...
    'Optimización sin restricciones',...
    'Salir') %Menú de selección de método%
if (selection == 3)
   return 
end
switch selection
    case 1 % Bisección %
        disp('Método de Bisección seleccionado.');
    case 2 % Wolfe %
        disp('Método de Wolfe seleccionado.');
        wolfeMethod();
    case 3 % Salir %
        disp('Fin del programa.');
end


