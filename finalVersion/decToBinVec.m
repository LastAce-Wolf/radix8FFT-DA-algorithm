%%x is within range of int17
%%transform a decimal number to a binary number int17
function res = decToBinVec(x)
    res = zeros(1,17);

    for n = 1:17
        res(n) = bitget(x , n , "int32");
    end
end

