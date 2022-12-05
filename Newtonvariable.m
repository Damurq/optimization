syms x y;

f = input("\nIngrese la funcion objetivo: ");
fM = matlabFunction(f, 'Vars', [x,y]);

x0 = input("\nIngrese el punto inicial: ");

tol = 10^(-6);

alfa = 1;

k = 0;


gradientf = gradient(f);
gradientfM = matlabFunction(gradientf, 'Vars', [x,y]);

hessianf = hessian(f, [x,y]);
hessianfM = matlabFunction(hessianf, 'Vars', [x,y]);

gradientf_k = gradientfM(x0(1), x0(2));

if gradientf_k == 0
    
    foptimal = fM(x0(1), x0(2));
    fprintf('\nel punto optimo es el punto inicial: (%1.3f,%1.3f) \n', x0(1),x0(2));
    fprintf('\nel valor optimo es %1.3f \n', foptimal);
   
    
    
else
    
    fprintf('k \t\t\t punto \t\t\t alfa \t\t dir.descenso \t norma \n');
    fprintf('__________________________________________________________________\n');
    
    while norm(gradientf_k ,'inf') >= tol && k<=50
        
        gradientf_k = gradientfM(x0(1), x0(2));
    
        hessianf_k = hessianfM(x0(1), x0(2));

        d = -hessianf_k\gradientf_k;

        %imprimir iteracion, punto, XXtamaño pasoXX, direccion descenso y norma
        fprintf("%1.0f \t| (%1.3f,%1.3f) \t| %1.3f \t| (%1.3f,%1.3f) \t|  %1.3f \n",k,x0(1),x0(2),alfa,d(1),d(2),norm(gradientf_k));
   

        x1 = x0+alfa*d;

        x0 = x1;

        k=k+1;
        
          
    
    end
    
    foptimal = fM(x0(1), x0(2));
    
    fprintf('\nel punto optimo es (%1.3f,%1.3f) \n', x0(1),x0(2));
    fprintf('\nel valor optimo es %1.3f \n', foptimal);
    
    
   
end
