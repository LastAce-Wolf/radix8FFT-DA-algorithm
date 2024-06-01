%%测试64点伪DA 8基底FFT函数，测试函数fft64da，输出RMSE
totalRMSE = 0;
errSqrMat = zeros(1,10000);
testCycle = 1000;

for cycle = 1:testCycle
    xr = rand(1,64);
    for i = 1:64
        xr(i) = (xr(i) - 0.5) * 60000;
    end
    xi = rand(1,64);
    for i = 1:64
        xi(i) = (xi(i) - 0.5) * 60000;
    end
    xr = int16(floor(xr));
    xi = int16(floor(xi));
    x = double(xr) + (1i) * double(xi);

    y_ref = fft(x);
    y_test = fft64da(x);

    
    err = abs(y_test - y_ref);
    errSqr = err.^2;
    RMSE = sqrt(mean(errSqr));
    totalRMSE = totalRMSE + RMSE;


end

meanRMSE = totalRMSE/testCycle;
