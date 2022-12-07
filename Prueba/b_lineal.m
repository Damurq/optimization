function l=b_lineal(x,d,Fx,Gx) 
    l=1; 
    alfa=10^(-1); 
    beta=0.1; 
    c=1; 
    while ((fun(x+l*d)>Fx+alfa*l*Gx'*d) || ( gradf(x+l*d)'*d > beta*Gx'*d ))&& c < 100 
        l=0.5*l; 
        c=c+1; 
    end
end