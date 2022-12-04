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

% Método para calcular el gradiente de una función.
function grad = GradientFunction(x)
    grad = [-400*x(1)*(x(2)-x(1)^2)-2*(1-x(1)); 200*(x(2)-x(1)^2)];
end

