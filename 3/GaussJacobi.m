A = input('Digite a matriz de coeficientes: \n');
n = max(size(A));%O tamanho de A é o número de variáveis
repetir = 1;%Sentinela que detecta a ocorrência de falha no teste e repete o teste desde o início
It = 0;
Erro = 0;
%Teste de convergência
while repetir == 1
    for i = 1:n
        S = 0;
        for j = 1:n
            if i~=j
                S = S + A(i,j);%Soma o elementos da linha, exceto o da matriz diagonal
            end
        end
        
        repetir = 0;%Se a matriz A passar no teste não será preciso reiniciar os teste
        while S>A(i,i)
            repetir = 1;%Reinicia o teste com a nova matriz A, pois a matriz não passou no teste
            A = input('Não satisfaz a condição de convergência!\nDigite a matriz de coeficientes: \n');               
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
X = input('Chute as soluções do sistema de equações: \n');%Recebe a matrix X
es = epsilon();%Epsilon da máquina será o erro mínimo tolerado
iter = 0;

F = zeros(n);
d = zeros(n,1);

%Início da Iteração
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

Xnovo = F*X+d; %Faz a primeira iteração

while abs(max(Xnovo - X)/max(Xnovo))*100 >= es 
    X = Xnovo;
    Xnovo = F*X+d;
    iter = iter +1;
    It(iter) = iter;
    Erro(iter) = abs(max(Xnovo - X)/max(Xnovo))*100;%Armazena os erros aproximados de cada iteração
end
hold on;
plot(It,Erro);
xlabel('No. de iterações');
ylabel('Erro aproximado')
Xnovo
iter