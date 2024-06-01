%%计算zn0时用到的四输入查值表的实现函数。注意这里并没有模拟具体的查值表，而是构造了一个函数
function lutRes = lut4(x1 , x2 , x3 , x4 , a)
    lutRes = a(1)*x1 + a(2)*x2 + a(3)*x3 + a(4)*x4;
