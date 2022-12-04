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

% Método de búsqueda lineal.
function l = LinearSearch(f, x, d, Fx, Gf, Gx)
    l=1; 
    alfa=10^(-1); 
    beta=0.1; 
    c=1; 
    xp = x;
    
    dt = transpose(d);
    
    p = double(xp+l*dt);
    
    syms x y;
    Gp = double((subs(Gx,{x,y},{p(1),p(2)}))');
    
    while ((f(p) > Fx+alfa*l*Gf'*d) || ( Gp*d > beta*Gf'*d )) && (c < 100) 
        la=0.5*l;
        p = xp+la*dt;
        Gp = double((subs(Gx,{x,y},{p(1),p(2)}))');
        l = la;
        c=c+1; 
    end

end