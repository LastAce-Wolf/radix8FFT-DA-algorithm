function res = binVecRev(x)
    res = zeros(1,17);
    if x(5) == (0)
        for i = 1:17
            if x(i) == 1
                res(i) = 0;
            else
                res(i) = 1;
            end
        end
        res = binVecPlus(res , [1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0]);
    else %%x(5) == 1
        res = binVecPlus(x , [1	 1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]);
        for i = 1:17
            if res(i) == 1
                res(i) = 0;
            else
                res(i) = 1;
            end
        end
    end
end
