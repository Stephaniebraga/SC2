//Trabalho de Simulação
//Disciplina: Sistemas de Comunicação II
//Dupla: Stéphanie Braga e Hugaleno
//Questão 3 e 4- Equalizador ZF e Diagramas de Olho.

clc;
close;close;close;close;
clear;

//Gera o sinal
N = 500;
x = sign(rand(1,N,'n'));

//canal
h=[-0.25, 0.80, 0.2, -0.15, 0.10];

//Sinal após canal
y=filter(h,1,x); //fir

// Equalizador zero forcing com 7 coeficientes:
ncoef=7;
C=zeros(ncoef,1);
H=[h(2),h(1),0,0,0,0,0
   h(3),h(2),h(1),0,0,0,0
   h(4),h(3),h(2),h(1),0,0,0
   h(5),h(4),h(3),h(2),h(1),0,0
   0,h(5),h(4),h(3),h(2),0,0
   0,0,h(5),h(4),h(3),h(2),0
   0,0,0,h(5),h(4),h(3),h(2)];

//Calcula a ISI residual do Equalizador com cada atraso 
IESr=zeros(1,ncoef); //vetor para armazenar a IESr de cada atraso
hzs=zeros(ncoef,11); //armazenar o canal equalizado com cada atraso
i=1; 
while i<=ncoef
    C(i,1)=1;
    w = inv(H)*C;  //calcula os coeficientes do equalizador
    hzf = convol(h,w); 
    hzs(i,:)=hzf;
    IESr(i)=(sum(hzf.*hzf) - max(hzf.*hzf))/max(hzf.*hzf); //calcula a IESr
    C=zeros(ncoef,1);
    i=i+1;
end

minIESr=min(IESr);  //pega a mínima IESr
index=vectorfind(IESr,minIESr,'c'); //pega a coluna que contém a mínima IESr
C=zeros(ncoef,1); 
C(index,1)=1;
//mostra a melhor IESr
printf('***Melhor IESr na posiçao %d:', index);
disp(minIESr);

//Calcula os coeficientes do Equalizador com a melhor posição
w = inv(H)*C; 
hzf = convol(h,w);

//equalizando o sinal:
z= filter(w,1,y);


//**Plotagens**//

figure;
//mostra o sinal
subplot(4,1,1);
title('Sinal');
plot(1:N,x,'.'); 

//mostra o sinal apos canal
subplot(3,1,2);
title('Sinal após canal');
plot(1:N,y,'.'); 

//mostra o sinal equalizado
subplot(3,1,3);
title('Sinal equalizado');
plot(1:N,z,'.'); 

figure;
//mostra as Respostas ao Impulso do canal e do canal equalizado com cada atraso
subplot(2,4,1);
title('Resp. ao Imp. do canal');
plot2d3(h);
plot(h);
xgrid;

subplot(2,4,2);
title('Equalização com 1 atraso');
plot2d3(hzs(1,:));
plot(hzs(1,:));
xgrid;

subplot(2,4,3);
title('Equalização com 2 atrasos');
plot2d3(hzs(2,:));
plot(hzs(2,:));
xgrid;

subplot(2,4,4);
title('Equalização com 3 atrasos');
plot2d3(hzs(3,:));
plot(hzs(3,:));
xgrid;

subplot(2,4,5);
title('Equalização com 4 atrasos');
plot2d3(hzs(4,:));
plot(hzs(4,:));
xgrid;

subplot(2,4,6);
title('Equalização com 5 atrasos');
plot2d3(hzs(5,:));
plot(hzs(5,:));
xgrid;

subplot(2,4,7);
title('Equalização com 6 atrasos');
plot2d3(hzs(6,:));
plot(hzs(6,:));
xgrid;

subplot(2,4,8);
title('Equalização com 7 atrasos');
plot2d3(hzs(7,:));
plot(hzs(7,:));
xgrid;


figure;
//Mostra o Diagrama de olho do sinal antes do canal
subplot(3,1,1);
title('Diag. de olho - sinal antes do canal');
l1 = 1; l2 = 3; dif=l2-l1;
t1=l1;t2=l2;
lim=floor(N/l2);
for k=1:lim
    plot(t1:t2,x(l1:l2));
    l1 = l2; l2 = l1 + dif;
end

//Mostra o Diagrama de olho do sinal depois do canal
subplot(3,1,2);
title('Diag. de olho - sinal depois do canal');
l1 = 1; l2 = 3; dif=l2-l1;
t1=l1;t2=l2;
lim=floor(N/l2);
for k=1:lim
    plot(t1:t2,y(l1:l2));
    l1 = l2; l2 = l1 + dif;
end

//Mostra o Diagrama de olho do sinal após Equalizador ZF
subplot(3,1,3);
title('Diag. de olho - Sinal depois do Eq. ZF');
l1 = 1; l2 = 3; dif=l2-l1;
t1=l1;t2=l2;
lim=floor(N/l2);
for k=1:lim
    plot(t1:t2,z(l1:l2));
    l1 = l2; l2 = l1 + dif;
end

