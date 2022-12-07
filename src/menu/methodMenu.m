clear all;
selection = menu('Seleccione el método a utilizar',...
    'Método de Bisección',...
    'Método de Wolfe',...
    'Salir') %Menú de selección de método%
if (selection == 3)
   return 
end
algorithmMenu; % Invoca el menú de selección de algoritmo %
switch selection
    case 1 % Bisección %
        disp('Método de Bisección seleccionado.');
    case 2 % Wolfe %
        disp('Método de Wolfe seleccionado.');
        wolfeMethod();
    case 3 % Salir %
        disp('Fin del programa.');
end


