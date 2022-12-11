f = '9*(x-12)^2+10*(y-15)^2';
[f, vf, fs] = ReadFunction(f);
g = gradient(f, vf);


x0 = [1; 1];

a = 1;
b = 1;

maxIter = 10;

tol = 1e-4;

[x, fx] = AnotherWolfe(f, x0, a, b, maxIter, tol);

disp(double(x));
disp(double(fx));