function point = cauchy(fx, initial, tolerance, maxIter, bl,xx,yy)
    % cauchy algorithm
    % fx: string - función a optimizar
    % initial: vector column - Punto inicial
    % tolerance: float - Tolerancia buscada
    % maxIter: inter - Iteraciones maximas
    syms('z');
    dom = [0, Inf];
    do = true;
    sf = str2sym(fx); %retorna una función
    variables = symvar(sf); %retorna un vector fila con las variables Example [x,y]
    grad = gradient(sf, variables); % retorna un vector columna del gradiente
    point = initial; %Punto inicial
    iter = 0; %Numero de iteración
    while do
        x = point(1); %Coordenada X del Punto
        y = point(2); %Coordenada Y del Punto
        Fgrad = [subs(grad(1)); subs(grad(2))]; %Evaluación del punto en el Gradiente
        d =- [Fgrad(1); Fgrad(2)]; %Dirección de descenso
        if norm(Fgrad) <= tolerance %Comparamos con la tolerancia
            fprintf('¡Punto Obtenido!')
            break
        elseif iter >= maxIter %Comparamos con el maximo de iteraciones
            break
        else %Busqueda del Alfa (Busqueda lineal)
            g1 = point(1) + d(1) * z;
            g2 = point(2) + d(2) * z;
            x = g1; %Nuevo Punto X en funcion de Alfa
            y = g2; %Nuevo Punto Y en funcion de Alfa
            f_sub = subs(sf); %Sustituyendo valores en la funcion

            switch bl
                case 'Despeje'
                    alpha = solve(diff(f_sub), z); %Despeje de la variable Alfa
                case 'Bisección'
                    d2=transpose(d);
                    alfa = biseccion(f, var, x0, d2, tolerance, maxIter);
                case 'Wolfe'
                    a = dom(1);
                    b = dom(2);
                    alpha = Wolfe(sf, transpose(point), d, a, b, tolerance, maxIter * 10);
                otherwise
                    alpha = solve(diff(f_sub), z); %Despeje de la variable Alfa
            end
            S = point + (alpha * d); %Nuevo/siguiente punto a estudiar
            point = S;
        end
        fila = [iter, double(transpose(point)), double(alpha), double(transpose(d))];
        if iter == 0
            table = fila;
        else
            table = [table; fila];
        end
        iter = iter + 1; %Incremento del numero de Operación
    end
    %llamar a la funcion para realizar la grafica pasando como parametros,
    %la funcion, el intervalo del eje x, el intervalo del eje y, el punto
    %inicial y el punto optimo
    graph = graphf(sf, xx, yy, initial, point);

    fprintf('El punto obtenido en la iteracion N° %i es:\n', iter)
    f = figure;
    t = uitable('ColumnName', {'iteración', 'x1', 'x2', 'alfa', 'd1', 'd2'});
    drawnow;
    set(t, 'Data', table);
end
