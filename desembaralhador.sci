//Desembaralha um sinal
//Recebe: T - sinal a ser desembaralhado
//       firtD - Numero de atrasos do primeiro estágio
//       sescD - Numero de atrasos do primeiro estágio
//Retorna: S - Sinal desembaralhado

function[S] = desembaralhador(T, firstD, secD)
S=T(1,1:firstD);
nT=size(T,2);

//Embaralhador
i=firstD + 1;
while i< nT+1
    df=T(1,i-firstD);
    if(i>secD)
        ds=T(1,i-secD);
        S(1,i)=bitxor(bitxor(ds,df),T(i));       
    else
        S(1,i)=bitxor(T(i),df);
    end
    i=i+1;
end
//fim do embaralhador
endfunction
