clear all
selection = menu('Seleccione el método a utilizar',...
    'Método de Bisección',...
    'Método de Wolfe',...
    'Salir')
switch selection
    case 1 % Bisección %
        disp('Método de Bisección seleccionado.');
        return;
    case 2 % Wolfe %
        disp('Método de Wolfe seleccionado.');
        return;
    case 3 % Salir %
        disp('Fin del programa.');
        return;
end
