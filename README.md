使用DA算法的8点基8FFT计算。其中包含了未完全应用DA算法的64点FFT计算。  
8-point Radix-8 FFT computation by DA algorithm. 64-point FFT computation is included, but it is not perfectly realized by DA.

fft.pdf  
用到的r8fft算法出处。注意该论文中存在多处数学错误，仅我发现了的就有公式4，公式6，及公式6、7之间文段关于LUT规模的描述。正确版本请参照代码。
如果该论文涉及到版权问题，请联系我删除。

funcFiles  
包含了主要的函数文件和查值表。r8fftda2使用了4点内积求和来计算。r8fftda8使用了8点内积来计算。其他文件功能见文件名及注释。

testFiles  
用于测试上述目录各函数文件的准确性。测试基准主要为MATLAB内建fft()和dot()。测试指标主要为RMSE。
