%%用dotLUT计算r8fft，使用了严格意义的查值表规格，需要调用LUTofSinAndCos.mat
%%运算中使用4点内积来计算
%%输入1：16*16的输入序列，前八行为实部，后八行为虚部；
%%一行的各元素为原数据二进制表示的各bit，第一个元素对应LSB。
%%输入2,3：两个预先存储的查值表
%%输出：1*8行向量,double
function res = r8fftda2(x , cosLUTk , sinLUTk)
    xr = zeros(1,8);
    xi = zeros(1,8);
    %%reconstruct xr and xi in decimal format
    for k = 1:8
        for n = 1:15
            xr(k) = xr(k) + x(k , n)*(2^(n-1));
            xi(k) = xi(k) + x(k+8 , n)*(2^(n-1));
        end
        xr(k) = xr(k) - x(k , 16)*(2^15);
        xi(k) = xi(k) - x(k+8 , 16)*(2^15);
    end
            

    ar = [0 0 0 0 0 0 0 0];
    ai = [0 0 0 0 0 0 0 0];%%pure imaginative part
    xrDITeven = [xr(1)+xr(5) , xr(2)+xr(6) , xr(3)+xr(7) , xr(4)+xr(8)];
    xrDITodd = [xr(1)-xr(5) , xr(2)-xr(6) , xr(3)-xr(7) , xr(4)-xr(8)];
    xiDITeven = [xi(1)+xi(5) , xi(2)+xi(6) , xi(3)+xi(7) , xi(4)+xi(8)];
    xiDITodd = [xi(1)-xi(5) , xi(2)-xi(6) , xi(3)-xi(7) , xi(4)-xi(8)];

    %%构造查值表。对k从0到7都要构造,分cos和sin两个矩阵。这里的k是FFT(x)的序号，X(k)
    %%每行对应一个k
    %%查值时，按(b3n,b2n,b1n,b0n)_2的十进制值查询k行的对应位置元素。
% %     cosLUTk = zeros(8,16);
% %     sinLUTk = zeros(8,16);
% %     for k = 1:8
% %         %%so-called A in book
% %         cosmkpiover4 = [cos(0*(k-1)*pi/4) , cos(1*(k-1)*pi/4) , cos(2*(k-1)*pi/4) , cos(3*(k-1)*pi/4)];
% %         sinmkpiover4 = [sin(0*(k-1)*pi/4) , sin(1*(k-1)*pi/4) , sin(2*(k-1)*pi/4) , sin(3*(k-1)*pi/4)];
% %         for i = 1:16
% %             cosLUTk(k,i) = lut4(bitget(i-1 , 1 ,'int8') , bitget(i-1 , 2 ,'int8') , bitget(i-1 , 3,'int8') , bitget(i-1 , 4,'int8'), cosmkpiover4);
% %             sinLUTk(k,i) = lut4(bitget(i-1 , 1 ,'int8') , bitget(i-1 , 2 ,'int8') , bitget(i-1 , 3,'int8') , bitget(i-1 , 4,'int8'), sinmkpiover4);
% %         end
% %     end


    for k = 1:8
        cosmkpiover4 = [cos(0*(k-1)*pi/4) , cos(1*(k-1)*pi/4) , cos(2*(k-1)*pi/4) , cos(3*(k-1)*pi/4)];
        sinmkpiover4 = [sin(0*(k-1)*pi/4) , sin(1*(k-1)*pi/4) , sin(2*(k-1)*pi/4) , sin(3*(k-1)*pi/4)];
        if mod((k-1) , 2) == 0
            ar(k) = dotdaLUT(xrDITeven , cosmkpiover4 , cosLUTk(k,:)) + dotdaLUT(xiDITeven , sinmkpiover4 , sinLUTk(k,:));
            ai(k) = dotdaLUT(xrDITeven , sinmkpiover4 , sinLUTk(k,:)) - dotdaLUT(xiDITeven , cosmkpiover4 , cosLUTk(k,:));
        end
    
        if mod((k-1) , 2) == 1
           ar(k) = dotdaLUT(xrDITodd , cosmkpiover4 , cosLUTk(k,:)) + dotdaLUT(xiDITodd , sinmkpiover4 , sinLUTk(k,:));
           ai(k) = dotdaLUT(xrDITodd , sinmkpiover4 , sinLUTk(k,:)) - dotdaLUT(xiDITodd , cosmkpiover4 , cosLUTk(k,:)); 
        end
    end
    
    res = ar + (-1i) * ai;
end