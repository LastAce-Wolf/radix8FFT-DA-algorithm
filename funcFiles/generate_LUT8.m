    %%构造r8fftda8用到的查值表。对k从0到7都要构造,分re和im两个矩阵。这里的k是FFT(x)的序号，X(k)
    %%每行对应一个k
    %%查值时，按(b7n,b6n,b5n,b4n,b3n,b2n,b1n,b0n)_2的十进制值查询k行的对应位置元素。
    %%虚部和实部的计算要用到两个不同的LUT
    dot8LUTre = zeros(8,256);
    dot8LUTim = zeros(8,256);
    A = zeros(1,8);
    %%前256列用于Z_n1
    for k = 1:8
        %%so-called A in book
        cosmkpiover4 = [cos(0*(k-1)*pi/4) , cos(1*(k-1)*pi/4) , cos(2*(k-1)*pi/4) , cos(3*(k-1)*pi/4)];
        sinmkpiover4 = [sin(0*(k-1)*pi/4) , sin(1*(k-1)*pi/4) , sin(2*(k-1)*pi/4) , sin(3*(k-1)*pi/4)];
        A = [cosmkpiover4 , sinmkpiover4];
        B = [sinmkpiover4 , cosmkpiover4];
        for i = 1:256
            dot8LUTre(k,i) = lut8(bitget(i-1 , 1 ,'int16') , bitget(i-1 , 2 ,'int16') , bitget(i-1 , 3,'int16') , bitget(i-1 , 4,'int16'), bitget(i-1 , 5 ,'int16') , bitget(i-1 , 6 ,'int16') , bitget(i-1 , 7,'int16') , bitget(i-1 , 8,'int16'), A);
            dot8LUTim(k,i) = lut8(bitget(i-1 , 1 ,'int16') , bitget(i-1 , 2 ,'int16') , bitget(i-1 , 3,'int16') , bitget(i-1 , 4,'int16'), bitget(i-1 , 5 ,'int16') , bitget(i-1 , 6 ,'int16') , bitget(i-1 , 7,'int16') , bitget(i-1 , 8,'int16'), B);
        end
    end
% % 
% % 
% %     %%后256列用于Z_sign
% %     for k = 1:8
% %         for i = 257:512
% %             dot8LUTre(k,i) = (-1) * dot8LUTre(k , i-256);
% %             dot8LUTim(k,i) = (-1) * dot8LUTim(k , i-256);
% %         end
% %     end