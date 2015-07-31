//Embaralha um sinal
//Recebe: x - sinal a ser embaralhado
//       firtD - Numero de atrasos do primeiro estágio
//       secD - Numero de atrasos do primeiro estágio
//Retorna: T - Sinal embaralhado

function[T] = embaralhador(x, firstD, secD)
T=x(1,1:firstD);
nx=size(x,2);

//Embaralhador
i=firstD + 1;
while i< nx+1
    df=T(1,i-firstD);
    if(i>secD)
        ds=T(1,i-secD);
        T(1,i)=bitxor(bitxor(ds,df),x(i));       
    else
        T(1,i)=bitxor(x(i),df);
    end
    i=i+1;
end
//fim do embaralhador
endfunction
