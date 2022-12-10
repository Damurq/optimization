function output = ControllerNonLinear(fx, initial, maxIter, busquedaLineal, method, xx, yy)
    %myFun - Description
    %
    % Syntax: output = myFun(input)
    %
    % Long description
    tolerance = 0.00000000001;
    if fx ~= ""
        f = str2sym(fx);
        vf = symvar(f);
        if numel(vf) == 2
            tolerance = 0.00000000001;
            if method == "Cauchy - Gradiente Descendente"
                cauchy(fx, initial, tolerance, maxIter, busquedaLineal)
            elseif method == "Newton"
                Newton(fx, initial, tolerance, maxIter, busquedaLineal, xx, yy);
            end
        else
            warndlg('Debe introducir una función con 2 variables independientes - Ejem: x+2*y', 'Error')
        end
    else
        warndlg('Debe introducir una función', 'Error')
    end
end
