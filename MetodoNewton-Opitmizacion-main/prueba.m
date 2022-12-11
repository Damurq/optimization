clc
syms('z')
k=0; % Numero iteracion
tol=10^-6; %Tolerancia
l=1; %alfa

string_funcion= input('Digite la función a optimizar: ', 's'); % Entrada de la funcion

symbs_function = str2sym(string_funcion); % Convertir funcio

var = symvar(symbs_function); % Vector con variables de la funcion

f = symbs_function; % Función a Optimizar  

% Calcular gradiente
grad = gradient(f,var);
disp(grad);

n = numel(var); % Numero de variables

% Matrices inicializadas en ceros
p = zeros(1,n); % Matriz para los puntos iniciales
Fgrand=zeros(n,1); % Matriz para el gradiente evaluado en el punto
H=zeros(n,1); %Matriz para hessiano evaluado en el punto

% Ciclo para entrada de puntos iniciales
for i=1:n
    P_ini = input('Digite el valor de %v en el vector inicial: ','s');
    punto = str2sym(P_ini);
    p(1,i) = punto;
end

% Ciclo para calcular gradiente evaluado en el punto
for i=1:n
    fun=grad(i,1);
    Fgrand(i,1)=subs(fun,var,p);
end


% Ciclo para calcular hessiano evaluado en el punto
for i=1:n
    fun=grad(i,1);
    for j=1:n
        valor=diff(fun,var(1,j));
        resul=subs(valor,var,p);
        H(i,j)=resul;
    end
end

disp(p);
disp(H);
disp(f1);
disp(Fgrand);
