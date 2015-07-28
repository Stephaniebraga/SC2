clc;
close;
clear;
exec('/home/stephanie/Documentos/SC2/SC2/OnOff.sci');
//opcao=input("Para transmissão sem erro digite - 1%nPara transmissão com erro digite - 2\n");
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


y=On_off(x,bitResolution,p);
//mostra o sinal recuperado
subplot(4,1,4);
title('On-Off Recuperado');
plot(timeAxis, y ,"-o");
