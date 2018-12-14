fprintf('Escolha dois pontos no gr�fico\n\n');
x = -100:1:100;
y = funcao(x);
plot(x,y); %Plota o gr�fico da fun��o para escolha dos pontos.


xl = input('Limite inferior: ');
xu = input('Limite superior: ');
while (funcao(xl)*funcao(xu))>0
   xl = input('Limite inferior: ');
   xu = input('Limite superior: '); 
end

es = epsilon(); %Epsilon da m�quina
xr = bisseccao(xl,xu,es);
xr = regulafalsi(xl,xu,es);
xr = newton(xl,es);
