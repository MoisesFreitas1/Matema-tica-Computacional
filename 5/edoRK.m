h=input('Digite o incremento h para os valores de x:\n');
x0=input('Digite o x(0) da condição inicial:\n');
y0=input('Digite o y(0) da condição inicial:\n');
n=1;
    y=y0;
    x=x0;
    for i=1:n
        k1=f_edo(x,y);
        k2=f_edo(x+h/2,y+h/2*k1);
        k3=f_edo(x+h/2,y+h/2*k2);
        k4=f_edo(x+h,y+h*k3);
        y=y0+h/6*(k1+2*k2+2*k3+k4);
        x=x0+h;
    end
    fprintf('Valor da função f no ponto k é: %.4f\n',y)
    