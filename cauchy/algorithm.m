function point = cauchy(fx, initial, tolerance, maxIter)
    % cauchy algorithm
    % fx: string - función a optimizar
    % initial: vector column - Punto inicial
    % tolerance: float - Tolerancia buscada
    % maxIter: inter - Iteraciones maximas
    do = true;
    sf = str2sym(fx); %retorna una función
    variables = symvar(sf); %retorna un vector fila con las variables Example [x,y]
    grad = gradient(sf, v); % retorna un vector columna del gradiente
    point = initial;
    iter = 0;
    while do
        x = initial(1); y = initial(2);
        Fgrad = [subs(grad(1)), subs(grad(2))];
        if norm(Fgrad) <= tolerance
            break
        elseif iter >= maxIter
            break
        else
            g1 = point(1) + Fgrad(1)*z;
            g2 = point(2) + Fgrad(2)*z;
            x = g1; y = g2;
            f_sub = subs(f);
            alpha = solve(diff(f_sub), z);
            S = transpose(point) + (alpha*Fgrad);
            point = S;
        end
        iter = iter + 1;
    end
    disp(point);
end