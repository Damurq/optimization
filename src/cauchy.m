function point = cauchy(fx, initial, tolerance, maxIter, bl)
    % cauchy algorithm
    % fx: string - función a optimizar
    % initial: vector column - Punto inicial
    % tolerance: float - Tolerancia buscada
    % maxIter: inter - Iteraciones maximas
    syms('z');
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

        plot3(x, y, subs(sf), 'o') %Grafica Sencilla
        title 'Cauchy' %Titulo de la grafica
        xlabel 'x' %Nombre del eje X
        ylabel 'y' %Nombre del eje Y
        grid on %Activamos cuadrilla
        hold on %Mantenmos las graficas anteriores

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

    fprintf('El punto obtenido en la iteracion N° %i es:\n', iter)
    f = figure;
    t = uitable('ColumnName', {'iteración', 'x1', 'x2', 'alfa', 'd1', 'd2'});
    drawnow;
    set(t, 'Data', table);
    reshape
end
