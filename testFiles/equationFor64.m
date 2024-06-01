%%测试Radix-8FFT公式可行性
x = rand(1,64) * 1 + rand(1,64) * 1i;
F_e = zeros(1,64);
for k1 = 1:8
    for k2 = 1:8
        outerRes = 0;
        for n2 = 1:8
            innerRes = 0;
            for n1 = 1:8
                innerRes = innerRes + x(8*(n1-1)+n2)*exp(-(n1-1)*(k2-1)*2*pi*1i/8);
            end
            innerRes = innerRes * exp( (-1)*1i*2*pi*(n2-1)*(k2-1)/64);
            innerRes = innerRes * exp( (-1)*1i*2*pi*(n2-1)*(k1-1)/8);
            outerRes = outerRes + innerRes;
        end
        F_e((k1-1)*8 + k2) = outerRes;
    end
end
G = fft(x);
Hcmp = [F_e;G]';
cmp =(F_e-G)';