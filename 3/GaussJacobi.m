A = input('Digite a matriz de coeficientes: \n');
n = max(size(A));%O tamanho de A � o n�mero de vari�veis
repetir = 1;%Sentinela que detecta a ocorr�ncia de falha no teste e repete o teste desde o in�cio
It = 0;
Erro = 0;
%Teste de converg�ncia
while repetir == 1
    for i = 1:n
        S = 0;
        for j = 1:n
            if i~=j
                S = S + A(i,j);%Soma o elementos da linha, exceto o da matriz diagonal
            end
        end
        
        repetir = 0;%Se a matriz A passar no teste n�o ser� preciso reiniciar os teste
        while S>A(i,i)
            repetir = 1;%Reinicia o teste com a nova matriz A, pois a matriz n�o passou no teste
            A = input('N�o satisfaz a condi��o de converg�ncia!\nDigite a matriz de coeficientes: \n');               
            n = max(size(A));
            for h = 1:i
                S = 0;
                for l = 1:n
                    if h~=l
                    S = S + A(h,l);
                    end
                end
            end
        end
    end
end


B = input('Digite a matriz de B: \n');%Recebe a matriz B
X = input('Chute as solu��es do sistema de equa��es: \n');%Recebe a matrix X
es = epsilon();%Epsilon da m�quina ser� o erro m�nimo tolerado
iter = 0;

F = zeros(n);
d = zeros(n,1);

%In�cio da Itera��o
for i = 1:n
    for j = 1:n
       if i == j
          F(i,j) = 0;
       end
       if i~=j
          F(i,j) = (-1)*A(i,j)/A(i,i);%Calcula a matriz F
       end
    end
end

for i = 1:n
    d(i,1) = B(i)/A(i,i);%Calcula a matriz D
end

Xnovo = F*X+d; %Faz a primeira itera��o

while abs(max(Xnovo - X)/max(Xnovo))*100 >= es 
    X = Xnovo;
    Xnovo = F*X+d;
    iter = iter +1;
    It(iter) = iter;
    Erro(iter) = abs(max(Xnovo - X)/max(Xnovo))*100;%Armazena os erros aproximados de cada itera��o
end
hold on;
plot(It,Erro);
xlabel('No. de itera��es');
ylabel('Erro aproximado')
Xnovo
iter