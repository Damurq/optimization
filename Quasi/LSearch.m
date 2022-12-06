function alpha = LSearch(g, point, d)

    syms x y z;
    
    gt = transpose(g);
    
    comp = point + d * z;
    
    disp('Compuesto');
    disp(comp);
    
    gsup = subs(gt, {x,y}, {comp(1), comp(2)});
    disp('G super');
    disp(gsup);
    
    dif = gsup*d;
    
    disp('Difiero');
    disp(dif);
    
    alpha = double(solve(dif, z));
    
end

