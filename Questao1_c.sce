//Trabalho de Simulação
//Disciplina: Sistemas de Comunicação II
//Dupla: Stéphanie Braga e Hugaleno
//Questão 1 - item c: Sinalização bipolar e cálculo de espectro de potência.

clc;
close;
clear;

//gera sinal
N=1000;
b=rand(1,N); //Gera matriz com valores aleatórios entre 0 e 1.
x=round(b);  //arredonda os valores para 0 ou 1.

nx=size(x,2);     //retorna o número de colunas de x

bitResolution=10; //numero de amostras por cada simbolo da sequencia
bitTime=1;  //Tempo de bit

//matriz de 3 linhas que indica o pulso a ser usado em cada simbolo. 
p=[ones(1,bitResolution);ones(1,bitResolution)*-1;zeros(1,bitResolution)];

//pre-atribuição para y. Matriz de 1 linha e nx*bitResolution colunas.
y=zeros(1,nx*bitResolution);

n=20; //quantidade de bits da sequancia a serem plotados no gráfico
Nshow=n*bitResolution;

//eixo de tempo para plotagem
timeAxis=[0:Nshow-1]*(bitTime/bitResolution);

//gera sinalização bipolar NRZ
aux=1;
i=1;
while i< nx+1
    start = 1+(bitResolution*(i-1));
    fim = i*bitResolution;
    if (x(1,i)==1)
        if(aux==1)
            pol=1;
        else
            pol=2;
        end
        y(1,start:fim) = p(pol,:);
        aux=aux*-1;
    else
        y(1,start:fim) = p(3,:);
    end
    i=i+1;
end

//calcula o espectro de potência
sy=abs(fft(y));
sy=fftshift(sy);
sy=sy.*sy;

//***Plotagens***//
//mostra o codigo de linha bipolar NRZ
figure;
subplot(2,1,1);
title('Biplolar NRZ');
plot(timeAxis,y(1,1:Nshow), "-o");
xgrid;

//mostra o espectro de potência
subplot(2,1,2);
title('Espectro de Potência');
//plot(sy);
plot(sy);
