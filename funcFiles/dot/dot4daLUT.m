%%用DA算法计算两个4维向量的内积
%%输入x：输入向量，4维，数据满足int16范围
%%输入lutRow：查找表，32维行向量。前16位供Z_n1计算，
%%后16位与前16位按顺序相反，供Z_sign计算
%%输出：内积结果
function dotRes = dot4daLUT(x , lutRow)
    x = double(x);

    %%求取Z_sign
    
    bk16 = [bitget(x(1) , 32 ,'int32') , bitget(x(2) , 32 ,'int32') , bitget(x(3) , 32 ,'int32') , bitget(x(4) , 32 , 'int32')];
    i = bk16(4)*8 + bk16(3)*4 +bk16(2)*2+bk16(1)+1;
    zs = (-1) * lutRow(i);
    %%zs = (-1) * lutRow(i) * (2^31);
    for k = 1:31
        zs = zs * 2;
    end

    %%求取zn1
    %%查值时，按(b3n,b2n,b1n,b0n)_2的十进制值查询k行的对应位置元素。
    zn1 = 0;
    
    for n = 0:30
        %%i correspounds to the column index in lutRow, which is calculated
        %%under the rule by which LUT is generated. See generate_LUT
        i = bitget(x(1) , n+1 ,'int32') + bitget(x(2) , n+1 ,'int32')*2 + bitget(x(3) , n+1 ,'int32')*4 + bitget(x(4) , n+1 ,'int32')*8 + 1;
        temp = lutRow(i);
        for cycle = 0:n-1
            temp = temp * 2;
        end
        %%zn1 = zn1 + lutRow(i)*2^n;
        zn1 = zn1 + temp;
    end
    dotRes = zs + zn1;
end
