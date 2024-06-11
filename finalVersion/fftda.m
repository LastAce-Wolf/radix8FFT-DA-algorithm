% % 对函数的输入数据为16*16的矩阵。前八行为实部，后八行为虚部。每行都对应一个数的二进制表示。
% 每行第一个元素为LSB，最后一个元素为MSB。  
% % 在函数中间步骤中，由于存在一些中间量超出了int16的最值，所以在步骤中把数据的表达扩展到了17位。
% 这里不直接用int32是因为会增大误差，约四个数量级。  
% % binVecToDec、decToBinVec、binVecPlus和binVecRes为一些二进制运算相关的函数，用于对行向量保存的二进制数进行运算，满足二类补码规则。  
% % Plus为求加法，Rev为求相反数（用于求减法）。  
% % 用到的查找表仍然为LUTofDotMix.mat。
function res = fftda(x , dotMixLUTeven , dotMixLUTodd)
    dotMixLUTevenRe = dotMixLUTeven(1:4,:);
    dotMixLUTevenIm = dotMixLUTeven(5:8,:);
    dotMixLUToddRe = dotMixLUTodd(1:4,:);
    dotMixLUToddIm = dotMixLUTodd(5:8,:); 

    %%实部和虚部的二进制表示
    x = [x , x(:,16)];
    xr = x(1:8,:);
    xi = x(9:16,:);

           

    ar = [0 0 0 0 0 0 0 0];
    ai = [0 0 0 0 0 0 0 0];%%pure imaginative part

    xreven = zeros(4,17);
    xrodd = zeros(4,17);
    xieven = zeros(4,17);
    xiodd = zeros(4,17);
    for i = 1:4
        xreven(i,:) = binVecPlus(xr(i,:) , xr(i+4,:));
        xrodd(i,:) = binVecPlus(xr(i,:) , binVecRev(xr(i+4,:)));
        xieven(i,:) = binVecPlus(xi(i,:) , xi(i+4,:));
        xiodd(i,:) = binVecPlus(xi(i,:) , binVecRev(xi(i+4,:)));
    end
    %%8*17
    xevenr = [xreven ; xieven];
    xoddr = [xrodd ; xiodd];
    xeveni = [xreven ; binVecRev(xieven(1,:)) ; binVecRev(xieven(2,:)) ; binVecRev(xieven(3,:)) ; binVecRev(xieven(4,:))];
    xoddi = [xrodd ; binVecRev(xiodd(1,:)) ; binVecRev(xiodd(2,:)) ; binVecRev(xiodd(3,:)) ; binVecRev(xiodd(4,:))];

    %%for convenience
% %     xevenr = [xr(1)+xr(5) , xr(2)+xr(6) , xr(3)+xr(7) , xr(4)+xr(8) , xi(1)+xi(5) , xi(2)+xi(6) , xi(3)+xi(7) , xi(4)+xi(8)];
% %     xoddr = [xr(1)-xr(5) , xr(2)-xr(6) , xr(3)-xr(7) , xr(4)-xr(8) , xi(1)-xi(5) , xi(2)-xi(6) , xi(3)-xi(7) , xi(4)-xi(8)];
% %     xeveni = [xr(1)+xr(5) , xr(2)+xr(6) , xr(3)+xr(7) , xr(4)+xr(8) , -xi(1)-xi(5) , -xi(2)-xi(6) , -xi(3)-xi(7) , -xi(4)-xi(8)];
% %     xoddi = [xr(1)-xr(5) , xr(2)-xr(6) , xr(3)-xr(7) , xr(4)-xr(8) , -xi(1)+xi(5) , -xi(2)+xi(6) , -xi(3)+xi(7) , -xi(4)+xi(8)];

    ar(1) = dadot4([xevenr(1,:) ; xevenr(2,:) ; xevenr(3,:) ; xevenr(4,:)] , dotMixLUTevenRe(1,:));
    ai(1) = dadot4([xeveni(5,:) ; xeveni(6,:) ; xeveni(7,:) ; xeveni(8,:)] , dotMixLUTevenIm(1,:));
    ar(3) = dadot4([xevenr(1,:) ; xevenr(3,:) ; xevenr(6,:) ; xevenr(8,:)] , dotMixLUTevenRe(2,:));
    ai(3) = dadot4([xeveni(2,:) ; xeveni(4,:) ; xeveni(5,:) ; xeveni(7,:)] , dotMixLUTevenIm(2,:));
    ar(5) = dadot4([xevenr(1,:) ; xevenr(2,:) ; xevenr(3,:) ; xevenr(4,:)] , dotMixLUTevenRe(3,:));
    ai(5) = dadot4([xeveni(5,:) ; xeveni(6,:) ; xeveni(7,:) ; xeveni(8,:)] , dotMixLUTevenIm(3,:));
    ar(7) = dadot4([xevenr(1,:) ; xevenr(3,:) ; xevenr(6,:) ; xevenr(8,:)] , dotMixLUTevenRe(4,:));
    ai(7) = dadot4([xeveni(2,:) ; xeveni(4,:) ; xeveni(5,:) ; xeveni(7,:)] , dotMixLUTevenIm(4,:));
    
    for i = 2:2:8
        ar(i) = dadot6([xoddr(1,:);xoddr(2,:);xoddr(4,:);xoddr(6,:);xoddr(7,:);xoddr(8,:)] , dotMixLUToddRe(i/2,:));
        ai(i) = dadot6([xoddi(2,:);xoddi(3,:);xoddi(4,:);xoddi(5,:);xoddi(6,:);xoddi(8,:)] , dotMixLUToddIm(i/2,:));
    end


    res = ar + (-1i) * ai;
end