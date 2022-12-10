function output = ControllerNonLinear(fx, initial, maxIter, busquedaLineal, method)
    %myFun - Description
    %
    % Syntax: output = myFun(input)
    %
    % Long description
    if fx ~= ""
        f = str2sym(fx);
        vf = symvar(f);
        if numel(vf) == 2
            dom = [0, Inf];
            tolerance = 1e-6;
            if method == "Cauchy - Gradiente Descendente"
                cauchy(fx, initial, tolerance, maxIter, busquedaLineal)
            elseif method == "Quasi newton - DFP"
                QuasiNewton(fx,transpose(initial), dom, tolerance, maxIter, busquedaLineal, 2)
            elseif method == "Quasi newton - BFGS"
                QuasiNewton(fx,transpose(initial), dom, tolerance, maxIter, busquedaLineal, 1)
            end
        else
            warndlg('Debe introducir una función con 2 variables independientes - Ejem: x+2*y', 'Error')
        end
    else
        warndlg('Debe introducir una función', 'Error')
    end
end
