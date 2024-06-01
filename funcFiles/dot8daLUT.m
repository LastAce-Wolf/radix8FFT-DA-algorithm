%%用DA算法计算两个8维向量的内积
%%输入x：输入向量，8维，数据满足int16范围
%%输入a：因子向量，8维，数据不做特定范围要求。在真DA算法下实际无效。
%%输入lutRow：查找表，512维行向量。前256位供Z_n1计算，
%%后256位与前256位按顺序相反，供Z_sign计算
%%输出：内积结果
function dotRes = dot8daLUT(x , lutRow)
    x = double(x);

    %%求取Z_sign
    bk16 = [bitget(x(1) , 32 ,'int32') , bitget(x(2) , 32 ,'int32') , bitget(x(3) , 32 ,'int32') , bitget(x(4) , 32 , 'int32') ,... 
        bitget(x(5) , 32 ,'int32') , bitget(x(6) , 32 ,'int32') , bitget(x(7) , 32 ,'int32') , bitget(x(8) , 32 , 'int32')];
    i = bk16(8)*128 +bk16(7)*64 +bk16(6)*32 +bk16(5)*16 +bk16(4)*8 + bk16(3)*4 +bk16(2)*2+bk16(1)+1;
    zs = (-1) * lutRow(i) * (2^31);

    %%求取zn1
    %%查值时，按(b7n,b6n,b5n,b4n,b3n,b2n,b1n,b0n)_2的十进制值查询k行的对应位置元素。
    zn1 = 0;
    for n = 0:30
        %%i correspounds to the column index in lutRow, which is calculated
        %%under the rule by which LUT is generated.See generate_LUT8
        i = bitget(x(1) , n+1 ,'int32') + bitget(x(2) , n+1 ,'int32')*2 + bitget(x(3) , n+1 ,'int32')*4 + bitget(x(4) , n+1 ,'int32')*8 +...
            bitget(x(5) , n+1 ,'int32')*16 + bitget(x(6) , n+1 ,'int32')*32 + bitget(x(7) , n+1 ,'int32')*64 + bitget(x(8) , n+1 ,'int32')*128 + 1;
        zn1 = zn1 + lutRow(i)*2^n;
    end
    dotRes = zs + zn1;
end
