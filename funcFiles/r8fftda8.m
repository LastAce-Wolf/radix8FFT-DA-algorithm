%%用dot8LUT计算r8fft，使用了严格意义的查值表规格，需要调用LUTofDot8.mat
%%运算中使用八点内积来计算
%%输入1：16*16的输入序列，前八行为实部，后八行为虚部；
%%一行的各元素为原数据二进制表示的各bit，第一个元素对应LSB。
%%输入2,3：两个预先存储的查值表
%%输出：1*8行向量,double
function res = r8fftda8(x , dot8LUTre , dot8LUTim)
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

    for k = 1:8
        if mod((k-1) , 2) == 0
            ar(k) = dot8daLUT([xrDITeven , xiDITeven] , dot8LUTre(k,:));
            ai(k) = dot8daLUT([xrDITeven , (-1) * xiDITeven] , dot8LUTim(k,:));
        end
    
        if mod((k-1) , 2) == 1
            ar(k) = dot8daLUT([xrDITodd , xiDITodd] , dot8LUTre(k,:));
            ai(k) = dot8daLUT([xrDITodd , (-1) * xiDITodd] , dot8LUTim(k,:)); 
        end
    end
    
    res = ar + (-1i) * ai;
end