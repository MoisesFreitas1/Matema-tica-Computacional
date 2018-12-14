fprintf('Escolha dois pontos no gráfico\n\n');
x = -100:1:100;
y = funcao(x);
plot(x,y); %Plota o gráfico da função para escolha dos pontos.


xl = input('Limite inferior: ');
xu = input('Limite superior: ');
while (funcao(xl)*funcao(xu))>0
   xl = input('Limite inferior: ');
   xu = input('Limite superior: '); 
end

es = epsilon(); %Epsilon da máquina
xr = bisseccao(xl,xu,es);
xr = regulafalsi(xl,xu,es);
xr = newton(xl,es);
