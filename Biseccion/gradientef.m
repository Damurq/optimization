function Fgrand = gradientef(f,var,x0)

grad = gradient(f,var);% Calcular gradiente

n = numel(var); % Numero de variables

Fgrand=zeros(n,1); % Matriz para el gradiente evaluado en el punto

    % Ciclo para calcular gradiente evaluado en el punto
    for i=1:n
        fun=grad(i,1);
        Fgrand(i,1)=subs(fun,var,x0);
    end
end