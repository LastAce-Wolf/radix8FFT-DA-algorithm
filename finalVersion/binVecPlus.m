%%输入的是已经经过扩展的位
%%扩展示例 x = [x , x(16)]
function res = binVecPlus(x , y)
    res = x + y;
    for i = 1:16
        if res(i) == 2
            res(i) = 0;
            res(i+1) = res(i+1) + 1;
        end
        if res(i) == 3
            res(i) = 1;
            res(i+1) = res(i+1) + 1;
        end
    end
    res(17) = mod(res(17) , 2);