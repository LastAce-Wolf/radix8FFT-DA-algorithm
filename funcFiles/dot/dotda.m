%%用DA算法计算两个4维向量的内积
%%输入：两个四维向量，每个元素都要在int16范围内
%%输出：整数
function dotRes = dotda(x , a)
    x = double(x);
    a = double(a);

    %%求取Z_sign
    bk16 = [bitget(x(1) , 32 ,'int32') , bitget(x(2) , 32 ,'int32') , bitget(x(3) , 32 ,'int32') , bitget(x(4) , 32 , 'int32')];
    zs = 0;
    for i = 1:4
        zs = zs + a(i)*bk16(i);
    end
    zs = zs * (2^31) *(-1);
    
    %%求取zn1
    zn1 = 0;
    
    for n = 0:30
        zn1 = zn1 + (lut4(bitget(x(1) , n+1,'int32') , bitget(x(2) , n+1,'int32') , bitget(x(3) , n+1,'int32') , bitget(x(4) , n+1,'int32'), a))*2^n;
    end
    dotRes = zs + zn1;

end
