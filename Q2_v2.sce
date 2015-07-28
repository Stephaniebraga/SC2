//Trabalho de Simulação
//Disciplina: Sistemas de Comunicação II
//Dupla: Stéphanie Braga e Hugaleno
//Questão 2  Embaralhador e Desembaralhador de dados

clc;
close;
clear;
exec('/home/stephanie/Documentos/SC2/SC2/OnOff.sci');
exec('/home/stephanie/Documentos/SC2/SC2/embaralhador.sci');

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

//Gera a Sinalização On_Off de x
y=On_off(x,bitResolution,p);

//Embaralha
firstD=3;
secD=5;
//T=x(1,1:firstD);
//
////Embaralhador
//i=firstD + 1;
//while i< nx+1
//    df=T(1,i-firstD);
//    if(i>secD)
//        ds=T(1,i-secD);
//        T(1,i)=bitxor(bitxor(ds,df),x(i));       
//    else
//        T(1,i)=bitxor(x(i),df);
//    end
//    i=i+1;
//end
T=embaralhador(x,firstD,secD);
//fim do embaralhador


//gera o sinal embaralhado
//i=1;
//while i< nx+1
//    start = 1+(bitResolution*(i-1));
//    fim = i*bitResolution;
//    if (T(1,i)==1)
//        y2(1,start:fim) = p(1,:);
//        yerro(1,start:fim) = p(1,:);
//    else
//        y2(1,start:fim) = p(2,:);
//        yerro(1,start:fim) = p(2,:);
//    end
//    i=i+1;
//end

y2=On_off(T,bitResolution,p);
//gera erro de transmissão
bitErro=(ceil(rand(1,1)*10));
if(T(1,bitErro)==1)
    SbitErro=zeros(1,bitResolution);
else
    SbitErro=ones(1,bitResolution);
end

start = 1+(bitResolution*(bitErro-1));
fim = bitErro*bitResolution;

yerro(1,start:fim) = SbitErro;
//fim do erro de transmissão

S=T(1,1:firstD);
//Desembaralhador
i=firstD + 1;
while i< nx+1
    df=T(1,i-firstD);
    if(i>secD)
        ds=T(1,i-secD);
        S(1,i)=bitxor(bitxor(ds,df),T(i));       
    else
        S(1,i)=bitxor(T(i),df);
    end
    i=i+1;
end
//fim do desembaralhador

//gera o sinal desembaralhado
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
subplot(4,1,1);
title('On-Off NRZ');
//ylabel('biplolar NRZ');
plot(timeAxis,y, "-o");
//plot2d3('gnn',timeAxis,y);
xgrid;

//mostra o sinal embaralhado
subplot(4,1,2);
title('On-Off Embaralhado');
plot(timeAxis, y2, "-o");

////mostra o sinal com erro
//subplot(4,1,3);
//title('On-Off com erro de transmissão');
//plot(timeAxis, yerro ,"-o");

//mostra o sinal recuperado
subplot(4,1,4);
title('On-Off Recuperado');
plot(timeAxis, y3 ,"-o");
