%%64点Radix-8 FFT测试，测试函数fft64。
totalRMSE = 0;
errSqrMat = zeros(1,10000);
testCycle = 1000;

for cycle = 1:testCycle
    xr = rand(1,64);
    for i = 1:64
        xr(i) = (xr(i) - 0.5) * 3000;
    end
    xi = rand(1,64) * 1i;
    for i = 1:64
        xi(i) = (xi(i) - 0.5i) * 3000;
    end
    x = xr+xi;

    y_ref = fft(x);
    y_test = fft64(x);

    
    err = abs(y_test - y_ref);
    errSqr = err.^2;
    RMSE = sqrt(mean(errSqr));
    totalRMSE = totalRMSE + RMSE;
    errSqrMat(cycle) = RMSE;
    errSqrMat = reshape(errSqrMat,100,100);

end

meanRMSE = totalRMSE/testCycle;
