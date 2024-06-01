%%用dotda计算r8fft，未使用严格的LUT
%%输入：1*8行向量,double
%%输出：1*8行向量,double
function res = r8fftda(x)

    xr = real(x);
    xi = imag(x);
    ar = [0 0 0 0 0 0 0 0];
    ai = [0 0 0 0 0 0 0 0];%%pure imaginative part
    xrDITeven = [xr(1)+xr(5) , xr(2)+xr(6) , xr(3)+xr(7) , xr(4)+xr(8)];
    xrDITodd = [xr(1)-xr(5) , xr(2)-xr(6) , xr(3)-xr(7) , xr(4)-xr(8)];
    xiDITeven = [xi(1)+xi(5) , xi(2)+xi(6) , xi(3)+xi(7) , xi(4)+xi(8)];
    xiDITodd = [xi(1)-xi(5) , xi(2)-xi(6) , xi(3)-xi(7) , xi(4)-xi(8)];
    
    for k = 1:8
        cosmkpiover4 = [cos(0*(k-1)*pi/4) , cos(1*(k-1)*pi/4) , cos(2*(k-1)*pi/4) , cos(3*(k-1)*pi/4)];
        sinmkpiover4 = [sin(0*(k-1)*pi/4) , sin(1*(k-1)*pi/4) , sin(2*(k-1)*pi/4) , sin(3*(k-1)*pi/4)];
        if mod((k-1) , 2) == 0
            ar(k) = dotda(xrDITeven , cosmkpiover4) + dotda(xiDITeven , sinmkpiover4);
            ai(k) = dotda(xrDITeven , sinmkpiover4) - dotda(xiDITeven , cosmkpiover4);
        end
    
        if mod((k-1) , 2) == 1
           ar(k) = dotda(xrDITodd , cosmkpiover4) + dotda(xiDITodd , sinmkpiover4);
           ai(k) = dotda(xrDITodd , sinmkpiover4) - dotda(xiDITodd , cosmkpiover4); 
        end
    end
    
    res = ar + (-1i) * ai;
end