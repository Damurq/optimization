function output = ControllerNonLinear(fx, initial, maxIter, busquedaLineal, method, xx, yy)
    %myFun - Description
    %
    % fx - string - función como string
    % initial - vector columna - Punto inial [X;Y]
    % maxIter - int - Número maximo de iteracioness
    % busquedaLineal - string - Nombre del método de busqueda no lineal
    % method - string - Nombre del método de busqueda lineal
    % xx - vector fila - (X1,X2)
    % yy - vector fila - (Y1,Y2)
    %
    % Long description
    if fx ~= ""
        f = str2sym(fx);
        vf = symvar(f);
        if numel(vf) == 2
            dom = [0, Inf];
            tolerance = 1e-6;
            if method == "Cauchy - Gradiente Descendente"
                cauchy(fx, initial, tolerance, maxIter, busquedaLineal, xx, yy)
            elseif method == "Newton"
                Newton(fx, initial, tolerance, maxIter, busquedaLineal, xx, yy);
            elseif method == "Quasi newton - DFP"
                QuasiNewton(fx,transpose(initial), dom, tolerance, maxIter, busquedaLineal, 2, xx, yy)
            elseif method == "Quasi newton - BFGS"
                QuasiNewton(fx,transpose(initial), dom, tolerance, maxIter, busquedaLineal, 1, xx, yy)
            end
        else
            warndlg('Debe introducir una función con 2 variables independientes - Ejem: x+2*y', 'Error')
        end
    else
        warndlg('Debe introducir una función', 'Error')
    end
end
