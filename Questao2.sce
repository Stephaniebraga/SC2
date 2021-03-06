//Trabalho de Simulação
//Disciplina: Sistemas de Comunicação II
//Dupla: Stéphanie Braga e Hugaleno
//Questão 2 - Embaralhador e Desembaralhador de dados

clc;
close;
clear;
exec('OnOff.sci');
exec('embaralhador.sci');
exec('desembaralhador.sci');

//gera sinal
N=35;
b=rand(1,N); //Gera matriz com valores aleatórios entre 0 e 1.
x=round(b);  //arredonda os valores para 0 ou 1.

nx=size(x,2);     //retorna o número de colunas de x

bitResolution=10; //numero de amostras por cada simbolo da sequencia
bitTime=1;  //Tempo de bit

//matriz de 3 linhas que indica o pulso a ser usado em cada simbolo. 
p=[ones(1,bitResolution);zeros(1,bitResolution)];

//pre-atribuição para y. Matriz de 1 linha e nx*bitResolution colunas.
y=zeros(1,nx*bitResolution);

//eixo de tempo para plotagem
timeAxis=[0:size(y,2)-1]*(bitTime/bitResolution);

//Gera a Sinalização On_Off apartir de x
y=On_off(x,bitResolution,p);

//Embaralhador
firstD=3; //Deslocamento Parcial
secD=5;   //Deslocamento final
T=embaralhador(x,firstD,secD); 

//gera o sinal embaralhado apartir de T
y2=On_off(T,bitResolution,p);

//gera erro de transmissão
TErro=T;
yerro=y2;
bitErro=(ceil(rand(1,1)*10)); //pega um valor randômico para o bit de erro
//Inverte o bit
if(T(1,bitErro)==1)
    TErro(bitErro)=0;
    SbitErro=zeros(1,bitResolution);
else
    SbitErro=ones(1,bitResolution);
    TErro(bitErro)=1;
end

start = 1+(bitResolution*(bitErro-1));
fim = bitErro*bitResolution;
yerro(1,start:fim) = SbitErro;

//Desembaralha o sinal correto
S=desembaralhador(T,firstD,secD);

//gera o sinal desembaralhado
y3=On_off(S,bitResolution,p);

//Desembaralha do sinal com erro
SErro=desembaralhador(TErro,firstD,secD);

//gera o sinal desembaralhado com erro
y4=On_off(SErro,bitResolution,p);

//**Plotagens**//

//mostra a Sinalização On-Off NRZ
subplot(5,1,1);
title('On-Off NRZ');
plot(timeAxis,y, "-o");
xgrid;

//mostra o sinal embaralhado
subplot(5,1,2);
title('On-Off Embaralhado');
plot(timeAxis, y2, "-o");

//mostra o sinal recuperado
subplot(5,1,3);
title('On-Off Recuperado');
plot(timeAxis, y3 ,"-o");

//mostra o sinal com erro
subplot(5,1,4);
title('On-Off com erro de transmissão');
plot(timeAxis, yerro ,"-o");

//mostra o sinal recuperado com erro
subplot(5,1,5);
title('On-Off Recuperado após erro');
plot(timeAxis, y4 ,"-o");

