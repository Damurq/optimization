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
function Fgrand = gradientef(f, var, x0)
%{
        Inputs:
            f: Función en formato string.
            var: variables de la funcion en forma de vector fila [x y]
            x0: Punto inicial en forma de vector fila.

        Outputs:
             Fgrand: el gradiente evaluado en el punto

    %}
    grad = gradient(f, var); % Calcular gradiente

    n = numel(var); % Numero de variables

    Fgrand = zeros(n, 1); % Matriz para el gradiente evaluado en el punto

    % Ciclo para calcular gradiente evaluado en el punto
    for i = 1:n
        fun = grad(i, 1);
        Fgrand(i, 1) = subs(fun, var, x0);
    end

end
