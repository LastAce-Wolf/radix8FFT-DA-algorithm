%%传进来的x 是4*17矩阵，每行为一个二进制表达，lsb在每行第一位
function dotRes = dadot4(x , lutRow)

    %%求取Z_sign    
    bk16 = [x(1,17) , x(2,17) , x(3,17) , x(4,17)];
    i = bk16(4)*8 + bk16(3)*4 +bk16(2)*2+bk16(1)+1;
    zs = (-1) * lutRow(i) * 2^16;

  
    %%求取zn1
    %%查值时，按(b3n,b2n,b1n,b0n)_2的十进制值查询k行的对应位置元素。
    zn1 = 0;
    for n = 0:15
        %%i correspounds to the column index in lutRow, which is calculated
        %%under the rule by which LUT is generated. See generate_LUT
        i = x(1,n+1) + x(2,n+1)*2 + x(3,n+1)*4 + x(4,n+1)*8 + 1;
        zn1 = zn1 + lutRow(i)*2^n;
    end
    dotRes = zs + zn1;
end
