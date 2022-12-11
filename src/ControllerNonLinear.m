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
function output = ControllerNonLinear(fx, initial, maxIter, busquedaLineal, method, xx, yy)
    % Método controlador para la vista del sistema
    %{
        Inputs:
            fx:             Función en formato string.
            initial:        Punto inicial en formato vector columna. P.ej. [x;y]
            maxIter:        Cantidad máxima de iteraciones a ejecutar por los
                            algoritmos.
            busquedaLineal: Nombre del método de búsqueda no lineal a
                            ejecutar en string.
                                - Biseccion
                                - Wolfe
                                - Despeje
            method:         Nombre del método de búsqueda lineal en formato
                            string.
                                - Cauchy - GradienteDescendente
                                - Newton
                                - Quasi newton - DFP
                                - Quasi newton BFGS
            xx:             Vector fila de dominio en eje X. P.ej. [X1, X2]
            yy:             Vector fila de dominio en eje Y. P.ej. [Y1, Y2]
        Outputs:
            output:         No se devuelve ningún valor.
    %}

    if fx ~= ""
        f = str2sym(fx);
        vf = symvar(f);
        if numel(vf) == 2
            dom = [0, Inf];
            tolerance = 1e-6;
            if method == "Cauchy - Gradiente Descendente"
                cauchy(fx, initial, tolerance, maxIter, busquedaLineal, xx, yy)
            elseif method == "Newton"
                Newton(fx, transpose(initial), tolerance, maxIter, busquedaLineal, xx, yy);
            elseif method == "Quasi newton - DFP"
                QuasiNewton(fx,transpose(initial), dom, tolerance, maxIter, busquedaLineal, 2, [xx, yy])
            elseif method == "Quasi newton - BFGS"
                QuasiNewton(fx,transpose(initial), dom, tolerance, maxIter, busquedaLineal, 1, [xx, yy])
            end
        else
            warndlg('Debe introducir una función con 2 variables independientes - Ejem: x+2*y', 'Error')
        end
    else
        warndlg('Debe introducir una función', 'Error')
    end
end
