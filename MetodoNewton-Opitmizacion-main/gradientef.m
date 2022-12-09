function Fgrand = gradientef(f,var,p)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% Calcular gradiente
grad = gradient(f,var);
n = numel(var); % Numero de variables
Fgrand=zeros(n,1); % Matriz para el gradiente evaluado en el punto
% Ciclo para calcular gradiente evaluado en el punto
for i=1:n
    fun=grad(i,1);
    Fgrand(i,1)=subs(fun,var,p);
end
end