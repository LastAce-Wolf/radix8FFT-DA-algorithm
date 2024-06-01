%%自制radix-8 8点FFT函数
%%输入：1*8行向量
%%输出：1*8行向量
function FFTresult = r8fft(x)

    xr = real(x);
    xi = imag(x);
    ar = [0 0 0 0 0 0 0 0];
    ai = [0 0 0 0 0 0 0 0];
    for k = 0:7
        for m = 1:4
            temp = ( (xr(m)+(-1)^k*xr(m+4))*cos((m-1)*k*pi/4) + (xi(m)+(-1)^k*xi(m+4))*sin((m-1)*k*pi/4) );
            ar(k+1) = ar(k+1) + temp;
            temp = ( (xr(m)+(-1)^k*xr(m+4))*sin((m-1)*k*pi/4) - (xi(m)+(-1)^k*xi(m+4))*cos((m-1)*k*pi/4) );
            ai(k+1) = ai(k+1) - temp * (1i);
        end
    end
    FFTresult = ar + ai;

end


