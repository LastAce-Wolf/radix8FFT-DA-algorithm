function res = binVecToDec(x)
    res = 0;
    for i = 1:16
        res = res + x(i)*(2^(i-1));
    end
    res = res - x(17)*(2^16);
end
