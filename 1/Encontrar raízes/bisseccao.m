function b = bisseccao(xl,xu,es)
    iter = 0;
    xr = (xl+xu)/2; %C�lcula o x de uma poss�vel ra�z entre xl e xu
    while (funcao(xl)*funcao(xr))~=0  %Quando essa condi��o n�o for mais satisfeita, encontramos a ra�z
        iter = iter + 1; %Conta o n�mero de itera��es
        xrold = xr; %Armazena o xr anterior
        if (funcao(xl)*funcao(xr))<0 %Existe uma ra�z entre xl e xr
            xu = xr;
        end
        if(funcao(xl)*funcao(xr))>0 %Existe uma ra�z entre xr e xu
            xl = xr;
        end
        xr = (xl+xu)/2; %C�lcula o xr para a pr�xima itera��o
        if xr~=0
            ea = abs((xr - xrold)/xr)*100;  %erro relativo aproximado
        end
        if ea <= es %Verifica se o erro relativo aproximado � maior que o epsilon da m�quina
            break;
        end
    end
    b = xr;
    fprintf('\nM�todo da Bissec��o:\n     Ra�z em %f\n     Itera��es: %d\n',b,iter);
end