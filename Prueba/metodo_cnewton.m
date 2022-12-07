clc 
% o es newton 
% 1 es estacionario 
% 2 con reinicios 
% 3 BFGS 
% 4 DFP 

met = 2;

% valores iniciales 
p = 4; 
x0 = [-1.2;1]; 
Fx = fun(x0); 
Gx = gradf(x0); 
Hx = Hessf(x0); 
Hfijo = Hx; 
l = 1; 
k = 0; 

% iniciamos el conteo de tiempo 
tic 
while norm(Gx,'inf') >= 10^(-3) && k<=1000 
    fprintf('%3.0f \t (%1.10f,%1.10f) \t %1.3f \t %3.3f \t %1.5f \n',k, x0(1), x0(2), l, norm(Gx), Fx) 
    % en caso necesario lo alteramos para que sea definida positiva 
    %H = mejora(Hx); 
    
    H=Hx; 
    % se usa la dirección del gradiente si está mal condicionada 
    if rcond(H)<10^(-5) 
        d = -Gx; 
    else
        d = -H\Gx; % Ax=b x=A\b
    end % usamos búsqueda lineal 
    
    l = b_lineal(x0,d,Fx,Gx); 
    x1 = x0+l*d; 
    Fx1 = fun(x1); 
    Gx1 = gradf(x1); 
    switch met 
        case 0 
            Hx = Hessf(x1); 
        case 1 
            Hx = Hfijo; 
        case 2 
            if mod(k+1,p)==0 
                Hx = Hessf(x1); 
            else
            end
        case 3 % BFGS 
            yk = Gx1-Gx; 
            s = l*d; 
            Hx = Hx+(yk*yk')/(yk'*s)-(Hx*s*s'*Hx)/(s'*Hx*s); 
        case 4 % DFP 
            yk = Gx1-Gx; 
            s = l*d; 
            Hx = Hx+((yk-Hx*s)*yk'+yk*(yk-Hx*s)')/(yk'*s)-((yk-Hx*s)'*s*yk*yk')/(yk'*s)^2; 
    end
    
    x0 = x1; 
    Fx = Fx1; 
    Gx = Gx1; 
    k = k+1; 
end

fprintf('%3.0f \t (%1.10f,%1.10f) \t %1.3f \t %3.3f \t %1.5f \n',k, x0(1), x0(2), l, norm(Gx), Fx) 
toc