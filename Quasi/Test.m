syms x y z
vz = symvar(f(x,y));
Gz = gradient(f(x,y), vz);
Hz = hessian(f(x,y), vz);
met = 2;
P = 2;
x0 = -1.2;
y0 = 1;
X0 = [-1.2, 1];
Fx = f(x0,y0);
Gx = subs(Gz,{x,y},{x0,y0});
Hx = subs(Hz,{x,y},{x0,y0});
NGx = double(norm(Gx));
Hfijo = Hx;
l = 1;
k = 0;

fprintf(' \t i \t (a, \t b) \t lambda \t ||gx|| \t f(x) \n')

while norm(Gx, 'inf') > 10^-3 && k <= 125
    fprintf('%3.0f \t (%1.3f,%1.3f) \t %1.3f \t %3.3f \t %1.5f \n',k, x0, y0, l, norm(Gx), Fx)
    H = Hx;

    if rcond(double(H)) < 10^-5
        d = -Gx;
    else
        d = -H\Gx;
    end
    l = b_lineal(x, y, X0, d, Fx, Gx, Gz);

    X1 = X0 + l*d;
    Fx1 = f(X1(1), X1(2));
    Gx1 = subs(Gz,{x,y},{X1(1), X1(2)});
    yk = Gx1 - Gx;
    s = l*d;
    switch met
        case 2
            Hx = Hx+(yk*yk')/(yk'*s)-(Hx*s*s'*Hx)/(s'*Hx*s);
        case 3
            Hx = subs(Hz,{x,y},{X1(1), X1(2)});
        case 4
            Hx = Hx+((yk-Hx*s)*yk'+yk*(yk-Hx*s)')/(yk'*s)-((yk-Hx*s)'*s*yk*yk')/(yk'*s)^2;
    end
    X0 = X1;
    Fx = Fx1;
    Gx = Gx1;
    k = k + 1;
end

function z = f(x,y)
    z = 100*(y-x^2)^2+(1-x)^2;
end

function l = b_lineal(x, y, w, d, Fx, Gx, Gz)
    l = 1;
    alfa = 10^-1;
    beta = 0.1;
    c = 1;
    Xd = w + l*d;
    while ((f(Xd(1), Xd(2))>Fx+alfa*l*Gx'*d) || (subs(Gz,{x,y},{Xd(1), Xd(2)})'*d > beta*Gx'*d)) && c < 100
        la = 0.5*l;
        Xd = w + la*d;
        c = c + 1;
        l = la;
    end
end