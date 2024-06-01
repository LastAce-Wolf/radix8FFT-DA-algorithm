    %%构造r8fftda用到的查值表。对k从0到7都要构造,分cos和sin两个矩阵。这里的k是FFT(x)的序号，X(k)
    %%每行对应一个k
    %%查值时，按(b3n,b2n,b1n,b0n)_2的十进制值查询k行的对应位置元素。
    cosLUTk = zeros(8,32);
    sinLUTk = zeros(8,32);
    %%前16列用于Z_n1
    for k = 1:8
        %%so-called A in book
        cosmkpiover4 = [cos(0*(k-1)*pi/4) , cos(1*(k-1)*pi/4) , cos(2*(k-1)*pi/4) , cos(3*(k-1)*pi/4)];
        sinmkpiover4 = [sin(0*(k-1)*pi/4) , sin(1*(k-1)*pi/4) , sin(2*(k-1)*pi/4) , sin(3*(k-1)*pi/4)];
        for i = 1:16
            cosLUTk(k,i) = lut4(bitget(i-1 , 1 ,'int8') , bitget(i-1 , 2 ,'int8') , bitget(i-1 , 3,'int8') , bitget(i-1 , 4,'int8'), cosmkpiover4);
            sinLUTk(k,i) = lut4(bitget(i-1 , 1 ,'int8') , bitget(i-1 , 2 ,'int8') , bitget(i-1 , 3,'int8') , bitget(i-1 , 4,'int8'), sinmkpiover4);
        end
    end

    %%后16列用于Z_sign
    for k = 1:8
        for i = 17:32
            cosLUTk(k,i) = (-1) * cosLUTk(k , i-16);
            sinLUTk(k,i) = (-1) * sinLUTk(k , i-16);
        end
    end
