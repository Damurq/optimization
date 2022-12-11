function point = cauchy(fx, initial, tolerance, maxIter, bl,xx,yy)
    % cauchy algorithm
    % fx:           string - función a optimizar
    % initial:      vector column - Punto inicial
    % tolerance:    float - Tolerancia buscada
    % maxIter:      int - Iteraciones maximas
    syms('z');
    dom = [0, Inf];             % Dominio para aplicar Wolfe    - vector fila
    do = true;                  % Ejecuta el while              - bolean
    sf = str2sym(fx);           % retorna una función           - sym
    variables = symvar(sf);     % variables. Example [x,y]      - vector fila
    grad = gradient(sf, variables); % retorna un vector columna del gradiente
    point = initial;                % Punto actual      - vector columna
    iter = 0;                       % Iteración actual  - int
    while do
        x = point(1); %Coordenada X del Punto
        y = point(2); %Coordenada Y del Punto
        Fgrad = [subs(grad(1)); subs(grad(2))]; %Evaluación del punto en el Gradiente
        d =- [Fgrad(1); Fgrad(2)]; %Dirección de descenso
        if norm(Fgrad) == 0
            fprintf('¡Punto Obtenido!')
            break
        elseif norm(Fgrad) <= tolerance %Comparamos con la tolerancia
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
                    alpha = biseccion(sf, variables, transpose(point), transpose(d), tolerance, maxIter + 10);
                case 'Wolfe'
                    a = dom(1);
                    b = dom(2);
                    alpha = Wolfe(sf, transpose(point), d, a, b, tolerance, maxIter + 10);
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
    graph = graphf(sf, xx, yy, transpose(initial), transpose(point));
    tab = TableBuilder(table)
    msgbox(['El punto óptimo x* es:  ', num2str(double(transpose(point)))])
    msgbox(['Y el valor óptimo es: f(x*)    :  ', num2str(double(subs(sf,variables,transpose(point))))])
end
