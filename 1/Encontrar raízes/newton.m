function nr = newton(xl,es)
    iter = 0;
    xr = xl; 
    ea = 100;
    while ea>=es 
        iter = iter + 1;%Conta o número de iterações
        xrold = xr; %Armazena o xr anterior
        df = (funcao(xrold+200000*es)-funcao(xrold))/(200000*es); %Calcula a derivada em xrold
        if df == 0 %Se df = 0, xr vai para o infinito
            fprintf('\nDerivada igual a zero. Escolha outro x.');
            break;
        end
        xr = xrold - (funcao(xrold)/df); %Cálcula o x de uma possível raíz
        if xr~=0
            ea = abs((xr - xrold)/xr)*100; %erro relativo aproximado
        end
        if ea <= es %Verifica se o erro relativo aproximado é maior que o epsilon da máquina
            break;
        end
    end
    nr = xr;
    fprintf('\nMétodo de Newton-Raphson:\n     Raíz em %f\n     Iterações: %d\n',nr,iter);
end