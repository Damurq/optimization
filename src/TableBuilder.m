%{
 Optimización - 2022-2
  Trabajo computacional N°1
    Integrantes:
      - Brizuela, Yurisbellys. C.I: V-27.142.239
      - Manzano, Jesús. C.I: V-25.989.002
      - Miranda, Marihec. C.I: V-26.120.075
      - Montero, Michael. C.I: V-26.561.077
      - Rivero, Gustavo. C.I: V-26.772.857
      - Valladares, Luis. C.I: V-26.370.986
%}
function t = TableBuilder(table)
    % Método para dar formato a tabla.
    
    %{
        Inputs:
            table:  Componente de tabla a la que se dará formato.
        Outputs:
            t:      Componente de tabla con formato establecido.
    %}

    f = figure;
    t = uitable('ColumnName', {'iteración', 'x1', 'x2', 'alfa', 'd1', 'd2'});
    drawnow;
    % Establece las unidades de la tabla como porcentajes
    set(t, 'Units', 'normalized');
    % Define el nuevo tamaño de la tabla en porcentajes
    newPosition = [0 0 1 1];
    % Establece el nuevo tamaño de la tabla
    set(t, 'Position', newPosition);
    % Establece los datos
    set(t, 'Data', table);
end