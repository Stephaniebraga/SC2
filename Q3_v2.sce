//Trabalho de Simulação
//Disciplina: Sistemas de Comunicação II
//Dupla: Stéphanie Braga e Hugaleno
//Questão 3 e 4- Equalizador ZF e Diagramas de Olho.

clc;
close;close;close;close;
clear;

N = 100;
x = sign(rand(1,N,'n'));

//canal
h=[-0.25, 0.80, 0.2, -0.15, 0.10];

//Sinal pelo canal
y=filter(h,1,x); //fir

// Equalizador zero forcing com 5 coeficientes:
C=[0;0;1;0;0];  //vetor de coeficientes
H=[h(2),h(1),0,0,0
   h(3),h(2),h(1),0,0
   h(4),h(3),h(2),h(1),0
   h(5),h(4),h(3),h(2),h(1)
   0,h(5),h(4),h(3),h(2)];
wz = inv(H)*C;  //coeficientes do equalizador
hz = convol(h,wz);

// Equalizador zero forcing com 7 coeficientes:
C2=[0;0;0;0;0;0;1];  //coeficientes
H2=[h(2),h(1),0,0,0,0,0
   h(3),h(2),h(1),0,0,0,0
   h(4),h(3),h(2),h(1),0,0,0
   h(5),h(4),h(3),h(2),h(1),0,0
   0,h(5),h(4),h(3),h(2),0,0
   0,0,h(5),h(4),h(3),h(2),0
   0,0,0,h(5),h(4),h(3),h(2)];
wz2 = inv(H2)*C2;
hz2 = convol(h,wz2);

//Calculando a ISI residual
IESr=(sum(hz2.*hz2) - max(hz2.*hz2))/max(hz2.*hz2);
disp(IESr);


//equalizando o sinal:
z= filter(wz,1,y);
z2= filter(wz2,1,y);

//mostra o sinal
subplot(4,1,1);
title('Sinal');
plot(1:N,x,'.'); 

//mostra o sinal apos canal
subplot(4,1,2);
title('Sinal após canal');
plot(1:N,y,'.'); 

//mostra o sinal equalizado
subplot(4,1,3);
title('Sinal equalizado (ZF-5)');
plot(1:N,z,'.'); 

//mostra o sinal equalizado
subplot(4,1,4);
title('Sinal equalizado (ZF-7)');
plot(1:N,z2,'.'); 

////mostra todos os sinais
//figure;
////subplot(5,1,5);
//title('Todos os Sinais');
//plot(1:N,x,'o'); 
//plot(1:N,y,'r*');
//plot(1:N,z2,'kx');
//xgrid;
////plot(1:N,z2,'g*'); 
//
//figure;
////mostra a Resposta ao Impulso do canal
//subplot(3,1,1);
//title('Resposta ao Impulso do canal');
//plot2d3(h);
//plot(h);
//xgrid;
//
//subplot(3,1,2);
//title('Resposta ao Impulso após Eq. ZF (5)');
//plot2d3(hz);
//plot(hz);
//xgrid;
//
//subplot(3,1,3);
//title('Resposta ao Impulso após Eq. ZF (7)');
//plot2d3(hz2);
//plot(hz2);
//xgrid;
//
//figure;
//subplot(3,1,1);
//title('Diag. de olho - sinal antes do canal');
//p1 = 1; p2 = 3; 
//for k=1:25
//    plot(1:3,x(p1:p2));
//    p1 = p2; p2 = p1 + 2;
//end
//
//subplot(3,1,2);
//title('Diag. de olho - sinal depois do canal');
//p1 = 1; p2 = 3; 
//for k=1:25
//    plot(1:3,y(p1:p2));
//    p1 = p2; p2 = p1 + 2;
//end
//
//subplot(3,1,3);
//title('Diag. de olho - Sinal depois do Eq. ZF');
//p1 = 1; p2 = 3; 
//for k=1:25
//    plot(1:3,z2(p1:p2));
//    p1 = p2; p2 = p1 + 2;
//end
//
////plot2d3(hz2);
////plot(hz2);
//xgrid;
//
