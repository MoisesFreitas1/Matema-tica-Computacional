A = input('Digite a matriz de coeficientes: \n');
n = max(size(A)); %O tamanho de A � o n�mero de vari�veis
beta = ones(n,1); %Inicia o vetor beta onde ser�o armazenados os testes 
repetir = 1; %Sentinela que detecta a ocorr�ncia de falha em algum dos testes e repete o teste desde o in�cio
It = 0; %Conta o n�mero de itera��es
Erro = 0;

%Teste de Converg�ncia
while repetir == 1
    for i = 1:n
        S = 0;
        for j = 1:n
            if i~=j
                S = S + A(i,j); %Soma o elementos da linha, exceto o da matriz diagonal
            end
        end
        repetir = 0; %Se a matriz A passar em um dos testes n�o ser� preciso reiniciar os teste
        
        if i == 1
            beta(1) = S / abs(A(1,1)); %Calcula o Beta1
        end
        if i~=1
            S2 = 0;
            S3 = 0;
            for j=1:(i-1)
                S2 = S2 + (abs(A(i,j)) * beta(j)); %Calcula a primeira parcela do Beta
            end
            if (i+1) <= n
                for m=(i+1):n
                    S3 = S3 + abs(A(i,m)); %Calcula a segunda parcela do Beta
                end
            end
            beta(i) = (S2+S3)/abs(A(i,i)); %Calcula o Beta
        end
        while S>A(i,i) && beta(i) >= 1 %Verifica se a matriz A passou em algum dos teste, caso contr�rio ser� preciso entrar com outra matriz
            repetir = 1; %Reinicia o teste com a nova matriz A, pois a matriz n�o passou em nenhum dos testes
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

B = input('Digite a matriz de B: \n'); %Recebe a matriz B
X = input('Chute as solu��es do sistema de equa��es: \n'); %Recebe a matrix X
es = epsilon(); %Epsilon da m�quina ser� o erro m�nimo tolerado

%In�cio da Itera��o
for i=1:n
    aux = A(i,i);
    for j = 1:n
        A(i,j)=A(i,j)/aux; %Forma��o da matriz F em cima da matriz A
    end
    B(i) = B(i)/aux; %Forma��o da matriz D em cima da matriz B
end
for i = 1:n
    soma = B(i);
    for j = 1:n
        if i~=j
            soma = soma - A(i,j)*X(j); %Calcula o novo X(i), X=FX+D, usando os outros X(i) para isso
        end
    end
    X(i)=soma;
end
iter = 1;
It(iter) = iter;
continuar = 1; %Verifica se o erro aproximado � menor que o erro m�nimo estipulado
while continuar == 1 %Enquanto o erro aproximo for maior que o erro tolerado as itera��es continuam
    for i = 1:n
        Xvelho = X(i); %armazena o X(i) atual para calcular o erro 
        soma = B(i); %B repesenta a matriz D
        for j = 1:n
            if i~=j
                soma = soma - A(i,j)*X(j); %Calcula um novo X(i) usando os outros X(i) para isso
            end
        end
        X(i)=soma;
        if continuar == 1 && X(i)~=0
            ea = abs((X(i)-Xvelho)/X(i))*100; %Erro aproximado da itera��o
            if ea < es
                continuar = 0; %Se o erro for menor que es, encerra as itera��es
            end
        end
    end
    Erro(iter) = ea; %Armazena os erros aproximados de cada itera��o
    It(iter) = iter; %Armazena os n�meros das itera��es
    iter = iter + 1;
end

hold on;
plot(It,Erro);
xlabel('No. de itera��es');
ylabel('Erro aproximado')
X
iter