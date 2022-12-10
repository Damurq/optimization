function output = ControllerNonLinear(input)
    %myFun - Description
    %
    % Syntax: output = myFun(input)
    %
    % Long description
    fx = app.FuncinEditField.Value;
    if fx ~= ""
        f = str2sym(fx);
        vf = symvar(f);
        if numel(vf) == 2
            initial = [app.XEditField.Value; app.YEditField.Value];
            tolerance = 0.00000000001;
            maxIter = app.IteracionesEditField.Value;
            busquedaLineal = app.EscojaelmtododebusquedalinealButtonGroup.SelectedObject.Text;
            if app.CauchyGradienteDescendenteButton.Value == 1
                cauchy(f, vf, initial, tolerance, maxIter, busquedaLineal)
            end
        else
            warndlg('Debe introducir una función con 2 variables independientes - Ejem: x+2*y', 'Error')
        end
    else
        warndlg('Debe introducir una función', 'Error')
    end
end
