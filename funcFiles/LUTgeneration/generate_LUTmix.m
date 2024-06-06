%%generate lut mix
dotMixLUTevenRe = zeros(4 , 16);
dotMixLUToddRe = zeros(4 , 64);
dotMixLUTevenIm = zeros(4 , 16);
dotMixLUToddIm = zeros(4 , 64);

for i = 1:16
    a = [bitget(i-1 , 1 ,'int8') , bitget(i-1 , 2 ,'int8') , bitget(i-1 , 3,'int8') , bitget(i-1 , 4,'int8')];
    dotMixLUTevenRe(1,i) = dot(a , [1,1,1,1]);
    dotMixLUTevenRe(2,i) = dot(a , [1,-1,1,-1]);
    dotMixLUTevenRe(3,i) = dot(a , [1,-1,1,-1]);
    dotMixLUTevenRe(4,i) = dot(a , [1,-1,-1,1]);
    dotMixLUTevenIm(1,i) = dot(a , [1,1,1,1]);
    dotMixLUTevenIm(2,i) = dot(a , [1,-1,1,-1]);
    dotMixLUTevenIm(3,i) = dot(a , [1,-1,1,-1]);
    dotMixLUTevenIm(4,i) = dot(a , [-1,1,1,-1]);
end

for i = 1:64
    a = [bitget(i-1 , 1 ,'int16') , bitget(i-1 , 2 ,'int16') , bitget(i-1 , 3,'int16') ,...
        bitget(i-1 , 4,'int16'), bitget(i-1 , 5 ,'int16') , bitget(i-1 , 6 ,'int16')];
    dotMixLUToddRe(1,i) = dot(a , [1 0.707106781186548 -0.707106781186548 0.707106781186548 1 0.707106781186548]);
    dotMixLUToddRe(2,i) = dot(a , [1 -0.707106781186548 0.707106781186548 0.707106781186548 -1	0.707106781186547]);
    dotMixLUToddRe(3,i) = dot(a , [1 -0.707106781186548 0.707106781186547 -0.707106781186548 1 -0.707106781186549]);
    dotMixLUToddRe(4,i) = dot(a , [1 0.707106781186547 -0.707106781186547 -0.707106781186548 -1 -0.707106781186548]);
    dotMixLUToddIm(1,i) = dot(a , [0.707106781186548 1 0.707106781186548 1 0.707106781186548 -0.707106781186548]);
    dotMixLUToddIm(2,i) = dot(a , [0.707106781186548 -1	0.707106781186547 1 -0.707106781186548 0.707106781186548]);
    dotMixLUToddIm(3,i) = dot(a , [-0.707106781186548 1 -0.707106781186549 1 -0.707106781186548 0.707106781186547]);
    dotMixLUToddIm(4,i) = dot(a , [-0.707106781186548 -1 -0.707106781186548 1 0.707106781186547 -0.707106781186547]);
end


dotMixLUTeven = [dotMixLUTevenRe ; dotMixLUTevenIm];
dotMixLUTodd = [dotMixLUToddRe ; dotMixLUToddIm];
clear('dotMixLUTevenRe');
clear('dotMixLUTevenIm');
clear('i');
clear('a');
clear('dotMixLUToddRe');
clear('dotMixLUToddIm');
