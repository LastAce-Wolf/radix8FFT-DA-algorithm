%%测试伪DA算法四维向量内积函数，测试函数dotda。输出RMSE
totalError = 0;
for cycle = 1:100
    a = rand(1,4);
    for i = 1:4
        a(i) = (a(i)-0.5) * 60000;
    end
    a = int16(floor(a));
    a = double(a);

    x = rand(1,4);
    for i = 1:4
        x(i) = (x(i)-0.5) * 60000;
    end
    x = int16(floor(x));
    x = double(x);

    DAres = dotda(x , a);
    refRes = dot(x , a);
    totalError = totalError + DAres - refRes;
end
