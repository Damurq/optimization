function c = biseccion(fx, initial, tolerance, maxIter, dir, dd)
clc
syms('z');

    f = str2sym(fx);
    var = symvar(f);
    
    x0 = initial;
    
    tol = tolerance;
    
    k = 0;

    
    a=0;
    b=1;


fprintf('k \t\t punto \t\t\t alfa \t\t grad \t\t grad*dir.desc \n');

    while abs(b-a)>=tol && k<=maxIter
        c=(a+b)/2;
        
        g=gradientef(f, var, x0);
        
        if dir==1
            d=transpose(dd);
        else
            d=-g;
        end
    
        cal=x0+c*transpose(d);
    
        gradientf_k  = gradientef(f, var, cal);
        
        cond=transpose(d)*gradientf_k;
    
        fprintf('_____________________________________________________________________________________\n');
        fprintf("%1.0f \t| (%1.3f,%1.3f) \t| %1.3f \t| (%1.3f,%1.3f) \t|  %1.3f \n",k,a,b,c,gradientf_k(1),gradientf_k(2),cond);
        
        fila = [k, double(a), double(b), double(c), double(transpose(gradientf_k)), double(cond)];
    
                if k == 0
                    table = fila;
                elseif k>0
                    table = [table; fila];
                end
    
        if cond>0
            b=c;
        elseif cond<0
            a=c;
        end
        k=k+1;
    end

    f = figure;
    t = uitable('ColumnName', {'iteración', 'a', 'b', 'c', 'g1', 'g2', 'Cond'});
    drawnow;
    set(t, 'Data', table);
end