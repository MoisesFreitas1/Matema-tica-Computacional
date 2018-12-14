function b = bisseccao(xl,xu,es)
    iter = 0;
    xr = (xl+xu)/2; %Cálcula o x de uma possível raíz entre xl e xu
    while (funcao(xl)*funcao(xr))~=0  %Quando essa condição não for mais satisfeita, encontramos a raíz
        iter = iter + 1; %Conta o número de iterações
        xrold = xr; %Armazena o xr anterior
        if (funcao(xl)*funcao(xr))<0 %Existe uma raíz entre xl e xr
            xu = xr;
        end
        if(funcao(xl)*funcao(xr))>0 %Existe uma raíz entre xr e xu
            xl = xr;
        end
        xr = (xl+xu)/2; %Cálcula o xr para a próxima iteração
        if xr~=0
            ea = abs((xr - xrold)/xr)*100;  %erro relativo aproximado
        end
        if ea <= es %Verifica se o erro relativo aproximado é maior que o epsilon da máquina
            break;
        end
    end
    b = xr;
    fprintf('\nMétodo da Bissecção:\n     Raíz em %f\n     Iterações: %d\n',b,iter);
end