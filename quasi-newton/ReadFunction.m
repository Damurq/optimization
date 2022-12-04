%{
 Optimización - 2022-2
  Trabajo computacional N°1
    Integrantes:
      - Brizuela, Yurisbellys. C.I: V-27.142.239
      - Manzano, Jesús. C.I: V-25.989.002
      - Miranda, Marihec. C.I: V-26.120.075
      - Montero, Michael. C.I: V-26.561.077
      - Gustavo Rivero. C.I: V-26.772.857
      - Valladares, Luis. C.I: V-26.370.986
%}

% Método para leer una función.
function [f,vf, Fx] = ReadFunction(prompt)
    fs = input(prompt, 's');    
    Fx = strrep(fs, 'x', 'x(1)');
    Fx = strrep(Fx, 'y', 'x(2)');
    Fx = strcat('@(x)', Fx);
    Fx = str2func(Fx);
    f = str2sym(fs);
    vf = symvar(f);
end

