function point = cauchy(fx, initial, tolerance, maxIter)
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
    point = initial;
    iter = 0;
    while do
        x = point(1); y = point(2);
        Fgrad = [subs(grad(1)); subs(grad(2))];
        Fgrad = -1*Fgrad;
        if norm(Fgrad) <= tolerance
            break
        elseif iter >= maxIter
            break
        else
            g1 = point(1) + Fgrad(1)*z;
            g2 = point(2) + Fgrad(2)*z;
            x = g1; y = g2;
            f_sub = subs(sf);
            alpha = solve(diff(f_sub), z);
            S = point + (alpha*Fgrad);
            point = S;
        end
        iter = iter + 1;
    end
    disp(point);
end