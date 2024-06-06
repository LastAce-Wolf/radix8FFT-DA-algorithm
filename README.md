使用DA算法的8点基8FFT计算。其中包含了未完全应用DA算法的64点FFT计算。  
8-point Radix-8 FFT computation by DA algorithm. 64-point FFT computation is included, but it is not perfectly realized by DA.

fft.pdf  
用到的r8fft算法。

funcFiles  
包含了主要的函数文件和查值表。r8fftda2使用了4点内积求和来计算。r8fftda8使用了8点内积来计算。其他文件功能见文件名及注释。
r8fftdaM使用了原论文里最终的简化方式，即根据k值的奇偶控制系数向量的规模在6或4，并分别用dot4和dot6计算。M代表mix。

testFiles  
用于测试上述目录各函数文件的准确性。测试基准主要为MATLAB内建fft()和dot()。测试指标主要为RMSE。
