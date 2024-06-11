使用DA算法的8点基8FFT计算。其中包含了未完全应用DA算法的64点FFT计算。  
8-point Radix-8 FFT computation by DA algorithm. 64-point FFT computation is included, but it is not perfectly realized by DA.

fft.pdf  
用到的r8fft算法。

funcFiles  
包含了主要的函数文件和查值表。r8fftda2使用了4点内积求和来计算。r8fftda8使用了8点内积来计算。其他文件功能见文件名及注释。
r8fftdaM使用了原论文里最终的简化方式，即根据k值的奇偶控制系数向量的规模在6或4，并分别用dot4和dot6计算。M代表mix。

testFiles  
用于测试上述目录各函数文件的准确性。测试基准主要为MATLAB内建fft()和dot()。测试指标主要为RMSE。

finalVersion  
最终版本，使用r8fftdaTest0.m来测试。  
对函数的输入数据为16*16的矩阵。前八行为实部，后八行为虚部。每行都对应一个数的二进制表示。每行第一个元素为LSB，最后一个元素为MSB。  
在函数中间步骤中，由于存在一些中间量超出了int16的最值，所以在步骤中把数据的表达扩展到了17位。这里不直接用int32是因为会增大误差，约四个数量级。  
binVecToDec、decToBinVec、binVecPlus和binVecRes为一些二进制运算相关的函数，用于对行向量保存的二进制数进行运算，满足二类补码规则。  
Plus为求加法，Rev为求相反数（用于求减法）。  
用到的查找表仍然为LUTofDotMix.mat。