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

% Se limpia la pantalla
clc

% Se declara e inicializa la variable para conocer la actualización del
% Cuasi-Newton a implementar.
met = 0;
while met ~= 1 && met ~= 2
    met    = input('Actualización de Cuasi-Newton \n(1) BFGS\n(2) DFP\nIndique el algoritmo a  implementar: ');
    if met ~= 1 && met ~= 2
        fprintf('El valor ingresado no es válido. Ingrese un nuevo valor...\n\n')
    end
end

% Se limpia la pantalla.
clc

% Se indica qué actualización de Cuasi-Newton a utilizar.
if (met == 1)
    fprintf('Actualización BFGS\n');
else
    fprintf('Actualización DFP\n');
end

% Se indica la función a optimizar.
[f,vf, fs] = ReadFunction('Indique la función a optimizar: ');

% Se indican el rango en el que se aplicará el algoritmo.
a = input('Indique el punto inferior: ');
b = input('Indique el punto superior: ');

% Se declaran e inicializan las variables a utilizar;
% Punto inicial
x0      = [a,b];
point = [a;b];

% Función iniciada en el punto [a,b]
Fx = fs(point);

disp(f);
disp(x0);

plot(point, Fx, '-s');


% Vector gradiente en el punto x0.
Gx = gradient(f,vf);
disp(Gx);
syms x y;
Gf = subs(Gx,{x,y},{a,b});
disp(Gf);
Gt = transpose(Gx);
Gtf = subs(Gt, {x,y},{a,b});
disp (Gtf);

% Matriz hessiana en el punto x0.
Hx      = hessian(f,vf);
disp(Hx);
Hf = subs(Hx, {x,y},{a,b});
disp(Hf);

% Matriz hessiana fijada en el punto x0.
Hfixed  = Hx;
% Lambda inicial = 1.
l       = 1;
% Iteración inicial = 0.
k       = 0;

% Se instancia la pantalla donde se visualizará la gráfica.
hold on;
plot([a;b], fs([a;b]), '-s');
grid on;
xlabel('x');
ylabel('y');

disp(norm(Gf, 'inf'));

% Se define la tabla que mostrará las iteraciones y se inician las
% iteraciones.
fprintf(' \t i \t (a, \t b) \t lambda \t ||gx|| \t f(x) \n')
while norm(Gf, 'inf') >= 10^(-3) && k <= 5
    
   fprintf('%3.0f \t (%1.3f,%1.3f) \t %1.3f \t %3.3f \t %1.5f \n',k, x0(1), x0(2), l, norm(Gf), Fx)
   
   % Se declara una hessiana como variable.
   H    = double(Hf);
   
   % Si la hessiana se encuentra mal condicionada:
   if rcond(H) < 10^(-5)
       % Se define una variable d como el gradiente negativo.
       d = -Gf;
   % Caso contrario, se define la variable d como la hessiana negativa
   % sobre el gradiente.
   else
       d = -H\Gf;
   end
   
   % Se define un lambda óptimo para la iteración.
   l    = LinearSearch(fs, x0, d, Fx, Gf, Gx);
   
   % Se calcula el punto x+1.
   x1   = x0+l*transpose(d);

   % Se evalúa la función y el gradiente en x+1.
   Fx1  = fs(x1);
   Gx1  = subs(Gx,{x,y},{x1(1),x1(2)});
   
   % Se calcula la diferencia de los gradientes Gx+1-Gx
   yk   = Gx1-Gx;
   
   % Se calcula el producto de lambda * d.
   s    = l*d;
   
   % Se aplica la actualización del Cuasi-Newton escogida:
   switch met
       case 1 %BFGS
           Hx = Hx+(yk*yk')/(yk'*s)-(Hx*s*s'*Hx)/(s'*Hx*s);
       case 2 %DFP
           Hx = Hx+((yk-Hx*s)*yk'+yk*(yk-Hx*s)')/(yk'*s)-((yk-Hx*s)'*s*yk*yk')/(yk'*s)^2;
   end
   
   % Se actualizan las variables a utilizar para la siguiente iteración.
   x0   = x1;
   Fx   = Fx1;
   Gx   = Gx1;
   Gf   = subs(Gx1,{x,y},{x1(1), x1(2)});
   k    = k+1;

   % Se grafican los puntos dados por la actualización.
   plot(x0, Fx, '-s');
   
end
hold off;