function[y] = On_off(x, bitResolution, p)
nx=size(x,2);
i=1;
while i< nx+1
    start = 1+(bitResolution*(i-1));
    fim = i*bitResolution;
    if (x(1,i)==1)
        y(1,start:fim) = p(1,:);
    else
        y(1,start:fim) = p(2,:);
    end
    i=i+1;
end
endfunction
