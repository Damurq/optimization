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
function [x0, Fx] = QuasiNewton(f, x0, dom, tol, maxIter, linearSearch, met, xy)
    %{
        Inputs:
            f: Función en formato string.
            x0: Punto inicial en forma de vector fila.
            dom: Dominio permitido (se sugiere [0, Inf] para Wolfe.)
            tol: Tolerancia aceptada.
            maxIter: Cantidad máxima de iteraciones.
            linearSearch: Tipo de búsqueda lineal como string;
                Bisección (Hay que adaptar).
                Wolfe.
            met: Cuasi-Newton a implementar - entero.
                (1) BFGS
                (2) DFP

        Outputs:
            x0: Punto mínimo obtenido.
            Fx: Valor mínimo obtenido.
    %}

    % Se limpia la pantalla
    clc

    % Se declara e inicializa la variable para conocer la actualización del
    % Cuasi-Newton a implementar.
    % met     = 0;
    % while met ~= 1 && met ~= 2
    %     met    = input('Actualización de Cuasi-Newton \n(1) BFGS\n(2) DFP\nIndique el algoritmo a  implementar: ');
    %     if met ~= 1 && met ~= 2
    %         fprintf('El valor ingresado no es válido. Ingrese un nuevo valor...\n\n')
    %     end
    % end

    % Se limpia la pantalla.
    clc

    % Se indica qué actualización de Cuasi-Newton a utilizar.
    if (met == 1)
        fprintf('Actualización BFGS\n');
    else
        fprintf('Actualización DFP\n');
    end

    % Se indica la función a optimizar.
    [f, vf, fs] = ReadFunction(f);

    % Se indican el rango en el que se aplicará el algoritmo.
    a       = 1e-4;
    b       = 0.9;

    % Se declaran e inicializan las variables a utilizar;
    % Punto inicial
    point   = [x0(1); x0(2)];

    % Función iniciada en el punto [a,b]
    Fx      = fs(point);

    % Vector gradiente en el punto x0.
    Gx      = gradient(f,vf);

    syms x y;
    Gf      = subs(Gx,{x,y},{x0(1),x0(2)});
    
    % Lambda inicial = 1.
    l       = 1;
    % Iteración inicial = 0.
    k       = 0;

    % Se instancia la pantalla donde se visualizará la gráfica.

    Grade   = Gx;
    Hmet    = eye(length(vf));
    Gx      = Gf;
    d       = -Gf;

    % Se define la tabla que mostrará las iteraciones y se inician las
    % iteraciones.
    fprintf(' \t i \t (a, \t b) \t lambda \t ||gx|| \t f(x) \n')
    while norm(Gf) >= tol && k < maxIter

       fprintf('%3.0f \t (%1.3f,%1.3f) \t %1.3f \t %3.3f \t %1.5f \n',k, x0(1), x0(2), l, norm(Gf), Fx)

       % Se define un lambda óptimo para la iteración.
       switch linearSearch
           case 'Despeje'
               l = 1;
            case 'Bisección'
                d2=transpose(d);
                l = biseccion(f, vf, x0, d2, tol, maxIter);
            case 'Wolfe'
                l = Wolfe(f, x0, d, a, b, 1/3, maxIter);
                %[~, l] = AnotherWolfe(f, x0, a, b, tol, maxIter);
       end
       
       % Se calcula un nuevo punto.
       x1   = x0 + l * transpose(d);

       % Se evalúa la función y el gradiente en x+1.
       Fx1  = fs(x1);
       Gx1  = subs(Grade, {x,y}, {x1(1), x1(2)});

       % Se calcula la diferencia de los gradientes Gx+1-Gx
       yk   = Gx1 - Gx;

       % Se calcula el producto de la diferencia x1 - x0.
       s    = (x1 - x0)';

       % Se aplica la actualización del Cuasi-Newton escogida:
       switch met
           case 1 %BFGS
               Hmet = Hmet + ((1 + (yk' * Hmet * yk) / (s' * yk))' * ((s' * s) / (s' * yk))) - (((s * yk' * Hmet) + (Hmet * yk * s')) / (s' * yk));
           case 2 %DFP    
               Hmet = inv(Hmet + ((1 + (s' * Hmet * s) / (yk' * s))' * (yk' * yk) / (yk' * s)) - (((yk * s' * Hmet) + (Hmet * s * yk')) / (yk' * s)));
       end
       
        row = [double(k), double(x0(1)), double(x0(2)), double(l), double(norm(Gf)), double(Fx)];

        if k == 0
            table = row;
        else
            table = [table; row];
        end
        
       % Se actualizan las variables a utilizar para la siguiente iteración.
       x0   = x1;
       Fx   = Fx1;
       Gx   = Gx1;
       Gf   = subs(Grade,{x,y},{x1(1), x1(2)});
       k    = k+1;
       d    = -Hmet*Gf;

       % Se grafican los puntos dados por la actualización.
       plot3(x0(1), x0(2), Fx, 'o'); %Grafica Sencilla

    end
    graph = graphf(f, xy(1), xy(2), point, x0);

    hold off;
    
    fig = figure;
    fig.Name = 'Tabla del método Cuasi-Newton';
    uiTable = uitable('ColumnName', {'iteración', 'x1', 'x2', 'alfa', '||g(x)||', 'f(x)'});
    drawnow;
    set(uiTable, 'Data', table);
    
    % Establece las unidades de la tabla como porcentajes
    set(uiTable, 'Units', 'normalized');

    % Define el nuevo tamaño de la tabla en porcentajes
    newPosition = [0 0 1 1];

    % Establece el nuevo tamaño de la tabla
    set(uiTable, 'Position', newPosition);
    %reshape;
    msgbox(['El punto óptimo x* es:  ', num2str(double(x0))])
    msgbox(['Y el valor óptimo es: f(x*)    :  ', num2str(double(subs(f,vf,x0)))])
end
