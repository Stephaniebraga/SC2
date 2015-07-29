//Trabalho de Simulação
//Disciplina: Sistemas de Comunicação II
//Dupla: Stéphanie Braga e Hugaleno
//Questão 3 - Equalizador ZF.

clc;
close;
clear;

p=[1,0,0,0,0];
//canal
h=[-0.25, 0.80, 0.2, -0.15, 0.10];

//h=[0.7, -0.35, 0.25, 0.15, -0.1];

// resposta em freq. do canal:
w=0:0.01:%pi;
z=exp(-%i*w); zk=z;
hz = h(1) + h(2)*z;
for k=3:5
    zk = zk.*z;
    hz = hz + h(k)*zk;
end
hza = abs(hz);

//mostra a Resposta ao Impulso do canal
subplot(2,1,1);
title('Resposta ao Impulso do canal');
plot2d3(h);
plot(h,"o");
xgrid;

//mostra a Resposta em frequência do canal
subplot(2,1,2);
title('Resposta em frequência do canal');
plot(w,hza);
xgrid;
