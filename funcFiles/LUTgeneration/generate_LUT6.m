%%构造r8fftda6用到的查值表。对k从0到7都要构造,依照k的奇偶性和时序部，共4个查找表。这里的k是FFT(x)的序号，X(k)
%%查值时
%%按(b5n,b4n,b3n,b2n,b1n,b0n)_2的十进制值查询k行的对应位置元素。
dot6LUTevenRe = zeros(4,64);
dot6LUToddRe = zeros(4,64);
dot6LUTevenIm = zeros(4,64);
dot6LUToddIm = zeros(4,64);
%%k为偶数时
for k = 1:2:8 %%在这里取1 3 5 7
    %%下面的k都要减一，为0 2 4 6
    cosmkpiover4 = [cos(0*(k-1)*pi/4) , cos(1*(k-1)*pi/4) , cos(2*(k-1)*pi/4) , cos(3*(k-1)*pi/4)];
    sinmkpiover4 = [sin(1*(k-1)*pi/4) , sin(3*(k-1)*pi/4)];
    A = [cosmkpiover4 , sinmkpiover4];
    B = [sinmkpiover4 , cosmkpiover4];
    for i = 1:64
        %%注意行号，最终还得是1 2 3 4
        dot6LUTevenRe((k+1)/2 , i) = lut6(bitget(i-1 , 1 ,'int16') , bitget(i-1 , 2 ,'int16') , bitget(i-1 , 3,'int16') , bitget(i-1 , 4,'int16'), bitget(i-1 , 5 ,'int16') , bitget(i-1 , 6 ,'int16'), A);
        dot6LUTevenIm((k+1)/2 , i) = lut6(bitget(i-1 , 1 ,'int16') , bitget(i-1 , 2 ,'int16') , bitget(i-1 , 3,'int16') , bitget(i-1 , 4,'int16'), bitget(i-1 , 5 ,'int16') , bitget(i-1 , 6 ,'int16'), B);
    end
end

%%k为奇数时
for k = 1:2:8 %%在这里取1 3 5 7
    cosmkpiover4 = [cos(0*k*pi/4) , cos(1*k*pi/4) , cos(3*k*pi/4)];
    sinmkpiover4 = [sin(1*k*pi/4) , sin(2*k*pi/4) , sin(3*k*pi/4)];
    A = [cosmkpiover4 , sinmkpiover4];
    B = [sinmkpiover4 , cosmkpiover4];
    for i = 1:64
        %%注意行号，最终还得是1 2 3 4
        dot6LUToddRe((k+1)/2 , i) = lut6(bitget(i-1 , 1 ,'int16') , bitget(i-1 , 2 ,'int16') , bitget(i-1 , 3,'int16') , bitget(i-1 , 4,'int16'), bitget(i-1 , 5 ,'int16') , bitget(i-1 , 6 ,'int16'), A);
        dot6LUToddIm((k+1)/2 , i) = lut6(bitget(i-1 , 1 ,'int16') , bitget(i-1 , 2 ,'int16') , bitget(i-1 , 3,'int16') , bitget(i-1 , 4,'int16'), bitget(i-1 , 5 ,'int16') , bitget(i-1 , 6 ,'int16'), B);
    end
end
dot6LUTre = [dot6LUTevenRe ; dot6LUToddRe];
dot6LUTim = [dot6LUTevenIm ; dot6LUToddIm];