%%用dotMixLUT计算r8fft，使用了严格意义的查值表规格，需要调用LUTofDotMix.mat
%%运算中使用4和6点内积来计算
%%输入1：16*16的输入序列，前八行为实部，后八行为虚部；
%%一行的各元素为原数据二进制表示的各bit，第一个元素对应LSB。
%%输入2,3：两个预先存储的查值表
%%输出：1*8行向量,double
function res = r8fftdaM(x , dotMixLUTeven , dotMixLUTodd)
    xr = zeros(1,8);
    xi = zeros(1,8);
    %%reconstruct xr and xi in decimal format
    for k = 1:8
        for n = 1:29
            xr(k) = xr(k) + x(k , n)*(2^(n-1));
            xi(k) = xi(k) + x(k+8 , n)*(2^(n-1));
        end
        xr(k) = xr(k) - x(k , 30)*(2^29);
        xi(k) = xi(k) - x(k+8 , 30)*(2^29);
    end
    dotMixLUTevenRe = dotMixLUTeven(1:4,:);
    dotMixLUTevenIm = dotMixLUTeven(5:8,:);
    dotMixLUToddRe = dotMixLUTodd(1:4,:);
    dotMixLUToddIm = dotMixLUTodd(5:8,:);
            

    ar = [0 0 0 0 0 0 0 0];
    ai = [0 0 0 0 0 0 0 0];%%pure imaginative part
    %%for convenience
    xevenr = [xr(1)+xr(5) , xr(2)+xr(6) , xr(3)+xr(7) , xr(4)+xr(8) , xi(1)+xi(5) , xi(2)+xi(6) , xi(3)+xi(7) , xi(4)+xi(8)];
    xoddr = [xr(1)-xr(5) , xr(2)-xr(6) , xr(3)-xr(7) , xr(4)-xr(8) , xi(1)-xi(5) , xi(2)-xi(6) , xi(3)-xi(7) , xi(4)-xi(8)];
    xeveni = [xr(1)+xr(5) , xr(2)+xr(6) , xr(3)+xr(7) , xr(4)+xr(8) , -xi(1)-xi(5) , -xi(2)-xi(6) , -xi(3)-xi(7) , -xi(4)-xi(8)];
    xoddi = [xr(1)-xr(5) , xr(2)-xr(6) , xr(3)-xr(7) , xr(4)-xr(8) , -xi(1)+xi(5) , -xi(2)+xi(6) , -xi(3)+xi(7) , -xi(4)+xi(8)];

    ar(1) = dot4daLUT([xevenr(1) , xevenr(2) , xevenr(3) , xevenr(4)] , dotMixLUTevenRe(1,:));
    ai(1) = dot4daLUT([xeveni(5) , xeveni(6) , xeveni(7) , xeveni(8)] , dotMixLUTevenIm(1,:));
    ar(3) = dot4daLUT([xevenr(1) , xevenr(3) , xevenr(6) , xevenr(8)] , dotMixLUTevenRe(2,:));
    ai(3) = dot4daLUT([xeveni(2) , xeveni(4) , xeveni(5) , xeveni(7)] , dotMixLUTevenIm(2,:));
    ar(5) = dot4daLUT([xevenr(1) , xevenr(2) , xevenr(3) , xevenr(4)] , dotMixLUTevenRe(3,:));
    ai(5) = dot4daLUT([xeveni(5) , xeveni(6) , xeveni(7) , xeveni(8)] , dotMixLUTevenIm(3,:));
    ar(7) = dot4daLUT([xevenr(1) , xevenr(3) , xevenr(6) , xevenr(8)] , dotMixLUTevenRe(4,:));
    ai(7) = dot4daLUT([xeveni(2) , xeveni(4) , xeveni(5) , xeveni(7)] , dotMixLUTevenIm(4,:));
    
    for i = 2:2:8
        ar(i) = dot6daLUT([xoddr(1),xoddr(2),xoddr(4),xoddr(6),xoddr(7),xoddr(8)] , dotMixLUToddRe(i/2,:));
        ai(i) = dot6daLUT([xoddi(2),xoddi(3),xoddi(4),xoddi(5),xoddi(6),xoddi(8)] , dotMixLUToddIm(i/2,:));
    end


    res = ar + (-1i) * ai;
end