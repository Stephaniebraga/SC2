//Trabalho de Simulação
//Disciplina: Sistemas de Comunicação II
//Dupla: Stéphanie Braga e Hugaleno
//Questão 3 - Equalizador ZF.

clc;
close;
clear;

//****SINAL****//
b=rand(1,10); //Gera matriz com valores aleatórios entre 0 e 1.
s=round(b);  //arredonda os valores para 0 ou 1.

ns=size(s,2);     //retorna o número de colunas de x

bitResolution=10; //numero de amostras por cada simbolo da sequencia
bitTime=1;  //Tempo de bit

//matriz de 3 linhas que indica o pulso a ser usado em cada simbolo. 
p=[ones(1,bitResolution);ones(1,bitResolution)*-1];

//pre-atribuição para x. Matriz de 1 linha e nx*bitResolution colunas.
x=zeros(1,ns*bitResolution);

//eixo de tempo para plotagem
timeAxis=[0:size(x,2)-1]*(bitTime/bitResolution);

//Sinal
i=1;
while i< ns+1
    start = 1+(bitResolution*(i-1));
    fim = i*bitResolution;
    if (s(1,i)==1)
        x(1,start:fim) = p(1,:);
    else
        x(1,start:fim) = p(2,:);
    end
    i=i+1;
end

//canal
h=[-0.25, 0.80, 0.2, -0.15, 0.10];

//Sinal pelo canal
y=filter(h,1,x);

// Equalizador zero forcing com 5 coeficientes:
C=[0;1;0;0;0];  //coeficientes
H=[h(2),h(1),h(1),0,0
   h(3),h(2),h(1),0,0
   h(4),h(3),h(2),h(1),0
   h(5),h(4),h(3),h(2),h(1)
   0,h(5),h(4),h(3),h(2)];
wz = inv(H)*C;
//hw = convol(h,wz); disp(hw);

// Equalizador zero forcing com 7 coeficientes:
C2=[0;0;0;1;0;0;0];  //coeficientes
H2=[h(2),h(1),h(1),0,0,0,0
   h(3),h(2),h(1),0,0,0,0
   h(4),h(3),h(2),h(1),0,0,0
   h(5),h(4),h(3),h(2),h(1),0,0
   0,h(5),h(4),h(3),h(2),0,0
   0,0,h(5),h(4),h(3),h(2),0
   0,0,0,h(5),h(4),h(3),h(2)];
wz2 = inv(H2)*C2;
//hw = convol(h,wz); disp(hw);


//equalizando o sinal:
z= filter(wz,1,y);
z2= filter(wz2,1,y);


//mostra o codigo de linha bipolar NRZ
subplot(4,1,1);
title('Sinal antes do canal');
plot(timeAxis,x, "-o");
xgrid;

//// resposta em freq. do canal:
//w=0:0.01:%pi;
//z=exp(-%i*w); zk=z;
//hz = h(1) + h(2)*z;
//for k=3:5
//    zk = zk.*z;
//    hz = hz + h(k)*zk;
//end
//hza = abs(hz);
//
////sinal após o canal:
////N = 130;
////a = sign(rand(1,N,'n'));
////af = filter(h,1,a);
////n = 0.1*rand(1,N,'n');
////af = af + n;
//
//
////mostra a Resposta ao Impulso do canal
//subplot(5,1,1);
//title('Resposta ao Impulso do canal');
//plot2d3(h);
//plot(h,"o");
//xgrid;
//
////mostra a Resposta em frequência do canal
//subplot(5,1,2);
//title('Resposta em frequência do canal');
//plot(w,hza);
//xgrid;
//
//
////mostra o sinal
//subplot(5,1,3);
//title('Sinal');
//plot(1:N,a,'.'); 

//mostra o sinal apos canal
subplot(4,1,2);
title('Sinal após canal');
//plot(1:N,af,'.'); 
plot(timeAxis,y, "-o");

//figure;
subplot(4,1,3);
title('Sinal eq');
plot(timeAxis,z, "-o");
//plot(1:N,az,'.'); 

subplot(4,1,4);
title('Sinal eq');
plot(timeAxis,z2, "-o");
