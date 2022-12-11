function c = biseccion(fx, initial, tolerance, maxIter, dir, dd)
clc
syms('z');

    f = str2sym(fx);
    var = symvar(f);
    n= numel(var);
    x0 = initial;
    
    tol = tolerance;
    
    k =0;
    fplot(f, initial)

if n==1
    a=x0(1);
    fa=subs(f,var,a);
    b=x0(2);
    fb=subs(f,var,b);
   
    
    if fa*fb>0
        c=(b+a)/2;
        
        fprintf('\nel punto optimo es (%1.3f,%1.3f) \n', a,b);
        fprintf('\nLa raiz de la solucion es %1.3f \n', c);
    else
        fprintf('k\t a\t b\t c\t f(a)\t f(b)\t f(c)\t f(a)*f(c)   ∣b-a∣ \n');
        val=abs(b-a);
        while val>=tol && k<=maxIter
            c=(b+a)/2;
            fc=subs(f,var,c);

            ff=fa*fc;
            
            fprintf('_________________________________________________________________________\n');
            fprintf(" %1.0f     | %1.3f | %1.3f | %1.3f |  %1.3f | %1.3f | %1.3f | %1.3f | %1.3f \n",k,a,b,c,fa,fb,fc,ff,val);
            fila = [k, double(a), double(b), double(c),  double(fa), double(fb), double(fc), double(ff), double(val)];
    
                if k == 0
                    table = fila;
                elseif k>0
                    table = [table; fila];
                end

            if fc==0
                fprintf('\nel punto optimo es (%1.3f,%1.3f) \n', a,b);
                fprintf('\nLa raiz de la solucion es %1.3f \n', c);
            else
                if ff<0
                    b=c;
                elseif ff>0
                    a=c;
                end
                val=abs(b-a);
                fa=subs(f,var,a);
                fb=subs(f,var,b);
                k=k+1;
            end
      
        end

        f = figure;
        t = uitable('ColumnName', {'iteración', 'a', 'b', 'c','f(a)', 'f(b)', 'f(c)', 'f(a)*f(c)', '∣b-a∣'});
        drawnow;
        set(t, 'Data', table);
        set(t,'Units', 'normalized');
        newPosition=[0 0 1 1];
        set(t, 'Position', newPosition);
        
    end

elseif n==2
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
    set(t,'Units', 'normalized');
    newPosition=[0 0 1 1];
    set(t, 'Position', newPosition);
end


end