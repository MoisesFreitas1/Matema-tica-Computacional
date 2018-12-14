function nr = newton(xl,es)
    iter = 0;
    xr = xl; 
    ea = 100;
    while ea>=es 
        iter = iter + 1;%Conta o n�mero de itera��es
        xrold = xr; %Armazena o xr anterior
        df = (funcao(xrold+200000*es)-funcao(xrold))/(200000*es); %Calcula a derivada em xrold
        if df == 0 %Se df = 0, xr vai para o infinito
            fprintf('\nDerivada igual a zero. Escolha outro x.');
            break;
        end
        xr = xrold - (funcao(xrold)/df); %C�lcula o x de uma poss�vel ra�z
        if xr~=0
            ea = abs((xr - xrold)/xr)*100; %erro relativo aproximado
        end
        if ea <= es %Verifica se o erro relativo aproximado � maior que o epsilon da m�quina
            break;
        end
    end
    nr = xr;
    fprintf('\nM�todo de Newton-Raphson:\n     Ra�z em %f\n     Itera��es: %d\n',nr,iter);
end