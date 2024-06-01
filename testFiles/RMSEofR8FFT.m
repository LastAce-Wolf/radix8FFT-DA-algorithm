%%8点Radix-8 FFT测试，测试函数r8fft，输出RMSE
totalRMSE = 0;
errSqrMat = zeros(1,10000);
testCycle = 1000;

for cycle = 1:testCycle
    xr = rand(1,8);
    for i = 1:8
        xr(i) = (xr(i) - 0.5) * 1000;
    end
    xi = rand(1,8) * 1i;
    for i = 1:8
        xi(i) = (xi(i) - 0.5i) * 1000;
    end
    x = xr+xi;

    y_ref = fft(x);
    y_test = r8fft(x);

    
    err = abs(y_test - y_ref);
    errSqr = err.^2;
    RMSE = sqrt(mean(errSqr));
    totalRMSE = totalRMSE + RMSE;

end

meanRMSE = totalRMSE/testCycle;