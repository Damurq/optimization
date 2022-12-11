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
function [f, vf, Fx] = ReadFunction(f)
    % Método para dar formato a una función. 
    %{
        Inputs:
            f: Función escrita en tipo string. P.ej x^2+y^2+1
        Outputs:
            f: Función en formato symbolic.
            vf:Variables de la función en vector fila. P.ej. [x y]
            Fx:Función en formato de función. P.ej. @(x) x^2+x+1
    %}
    fs = f;    
    Fx = strrep(fs, 'x', 'x(1)');
    Fx = strrep(Fx, 'y', 'x(2)');
    Fx = strcat('@(x)', Fx);
    Fx = str2func(Fx);
    f = str2sym(fs);
    vf = symvar(f);
end

