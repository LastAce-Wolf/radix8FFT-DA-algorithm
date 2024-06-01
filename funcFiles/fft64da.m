%%自制DA radix-8 64点FFT函数，第二级FFT的输入数据进行了舍入，旋转因子计算未做DA化
%%输入：1*64行向量
%%输出：1*64行向量
function FFT64Result = fft64da(x)
    y = reshape(x,8,8);
    y = y.';

    %%固定n2，对x[8*n1+n2]序列进行FFT，结果按行存入fftRes1
    %%fftRes1的行号对应n2，列号对应k2
    fftRes1 = zeros(8,8);
    for n2 = 1:8
        fftRes1(n2,:) = r8fftda( (y(:,n2)).' );
    end
    
    %%乘上旋转因子
    %%该矩阵就是x_cap(n2,k2)，其中行号为n2，列号为k2
    fftRes2 = zeros(8,8);
    for n2=1:8
        for k2=1:8
            fftRes2(n2,k2) = fftRes1(n2,k2) * exp(-1*1i * 2*pi * (n2-1) * (k2-1) / 64);
        end
    end
    
    %%固定k2，对x_cap(n2,k2)求FFT，即对fftRes1逐列求FFT
    %%结果按列存入F,F的行号代表n1，列号代表n2
    F = zeros(8,8);

    %%取整数近似，供下一级使用
    fftRes2r = real(fftRes2);
    fftRes2i = imag(fftRes2);
    fftRes2r = double(int64(fftRes2r));
    fftRes2i = double(int64(fftRes2i));
    fftRes2 = fftRes2r + (1i) * fftRes2i;


    for k2=1:8
        F(:,k2) = (r8fftda( ( fftRes2(:,k2) ).' )).';
    end

    FFT64Result = reshape(F.',1,64);
end