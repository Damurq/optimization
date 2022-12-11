function H = hessianof(Gx,var,p)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% Ciclo para calcular hessiano evaluado en el punto

n = numel(var); % Numero de variables
H=zeros(n,n); %Matriz para hessiano evaluado en el punto

for i=1:n
    fun=Gx(i,1);
    for j=1:n
        valor=diff(fun,var(1,j));
        resul=subs(valor,var,p);
        H(i,j)=resul;
    end
end

end