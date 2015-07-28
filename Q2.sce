//Trabalho de Simulação
//Disciplina: Sistemas de Comunicação II
//Dupla: Stéphanie Braga e Hugaleno
//Questão 2  Embaralhador e Desembaralhador de dados

clc;
close;
clear;
x=[1 0 1 0 1 0 1 0 0 0 0 0 1 1 1];  //Sequência de bits

//b=rand(1,10000); //Gera matriz com valores aleatórios entre 0 e 1.
//x=round(b);  //arredonda os valores para 0 ou 1.

nx=size(x,2);     //retorna o número de colunas de x

bitResolution=10; //numero de amostras por cada simbolo da sequencia
bitTime=1;  //Tempo de bit

//matriz de 3 linhas que indica o pulso a ser usado em cada simbolo. 
p=[ones(1,bitResolution);zeros(1,bitResolution)];

//pre-atribuição para y. Matriz de 1 linha e nx*bitResolution colunas.
y=zeros(1,nx*bitResolution);

//eixo de tempo para plotagem
timeAxis=[0:size(y,2)-1]*(bitTime/bitResolution);

aux=1;
i=1;
while i< nx+1
    start = 1+(bitResolution*(i-1));
    fim = i*bitResolution;
    if (x(1,i)==1)
        y(1,start:fim) = p(1,:);
    else
        y(1,start:fim) = p(2,:);
    end
    i=i+1;
end


//Embaralhador

D3=[zeros(1,3),x,zeros(1,12)];
D5=[zeros(1,5),x, zeros(1,10)];
D6=[zeros(1,6),x, zeros(1,9)];
D9=[zeros(1,9),x, zeros(1,6)];
D10=[zeros(1,10),x, zeros(1,5)];
D11=[zeros(1,11),x, zeros(1,4)];
D12=[zeros(1,12),x, zeros(1,3)];
D13=[zeros(1,13),x, zeros(1,2)];
D15=[zeros(1,15),x];

x2=[x,zeros(1,15)];
F=bitxor(D3,D5);
F=bitxor(F,D6);
F=bitxor(F,D9);
F=bitxor(F,D10);
F=bitxor(F,D11);
F=bitxor(F,D12);
F=bitxor(F,D13);
F=bitxor(F,D15);
T=bitxor(F,x2);

i=1;
while i< nx+1
    start = 1+(bitResolution*(i-1));
    fim = i*bitResolution;
    if (T(1,i)==1)
        y2(1,start:fim) = p(1,:);
    else
        y2(1,start:fim) = p(2,:);
    end
    i=i+1;
end

//Desembaralhador
S=bitxor(T,F);

i=1;
while i< nx+1
    start = 1+(bitResolution*(i-1));
    fim = i*bitResolution;
    if (S(1,i)==1)
        y3(1,start:fim) = p(1,:);
    else
        y3(1,start:fim) = p(2,:);
    end
    i=i+1;
end


//mostra a Sinalização On-Off NRZ
subplot(3,1,1);
title('On-Off NRZ');
//ylabel('biplolar NRZ');
plot(timeAxis,y, "-o");
//plot2d3('gnn',timeAxis,y);
xgrid;

//mostra o sinal embaralhado
subplot(3,1,2);
title('On-Off Embaralhado');
plot(timeAxis, y2, "-o");

//mostra o sinal recuperado
subplot(3,1,3);
title('On-Off Recuperado');
plot(timeAxis, y3 ,"-o");
