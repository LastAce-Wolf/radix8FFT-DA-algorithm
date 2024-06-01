%%8点DA Radix-8 FFT测试，测试函数r8fftda、r8fftda2、r8fftda8，输出RMSE
totalRMSE = 0;
errSqrMat = zeros(1,10000);
load('LUTofDot8.mat');
testCycle = 1000;

for cycle = 1:testCycle
    
    xr = rand(1,8);
    for i = 1:8
        xr(i) = (xr(i) - 0.5) * 60000;
    end
    xi = rand(1,8);
    for i = 1:8
        xi(i) = (xi(i) - 0.5) * 60000;
    end
    xr = int16(floor(xr));
    xi = int16(floor(xi));
    %%binary format input matrix.
    %%first 8 rows are xr's binary representation, LSB at first pos
    %%last 8 rows are xi's binary representation, LSB at first pos
    binInput = zeros(16,16);
    for k = 1:8
        for n = 1:16
            binInput(k , n) = bitget(xr(k) , n);
            binInput(k+8 , n) = bitget(xi(k) , n);
        end
    end

    x = double(xr) + (1i) * double(xi);

    y_ref = fft(x);

    %%要测试的函数。注意r8fftda不需要用binInput
    y_test = r8fftda8(binInput , dot8LUTre , dot8LUTim);

    
    err = abs(y_test - y_ref);
    errSqr = err.^2;
    RMSE = sqrt(mean(errSqr));
    totalRMSE = totalRMSE + RMSE;

end

meanRMSE = totalRMSE/testCycle;