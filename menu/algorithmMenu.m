selection = menu('Seleccione el algoritmo de descenso',...
    'Algoritmo de Newton',...
    'Algoritmo de Cauchy',...
    'Algoritmo de Cuasi-Newton',...
    'Volver a la selección de métodos')
switch selection
    case 1 % Newton %
        disp('Algoritmo de Newton seleccionado.');
    case 2 % Cauchy %
        disp('Algoritmo de Cauchy seleccionado.');
    case 3 % Cuasi-Newton %
        disp('Algoritmo de Cuasi-Newton seleccionado.');
    case 4 % Volver %
        methodMenu;
end