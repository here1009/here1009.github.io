---
layout: post
title: Fast Discrete Fourier Transform
date: 2017-02-10 24:00
---

----------------
<div>
if \( x\in \mathbb{C},\ n=2^t,\ t\in \mathbb{Z} \) <br/>

&emsp;&emsp;function fft(\(x\),\(n\)) <br/>
&emsp;&emsp;if(\(n==1\)) <br/>

$$ y=x $$
&emsp;&emsp;else <br/>
$$ m=\frac{n}{2} $$
$$ y_T=fft(x(1:2:n),m) $$
$$ y_B=fft(x(2:2:n),m) $$
$$ \omega=e^\frac{-2\pi i}{n} $$
$$ d=\left[1,\omega,\dots,\omega^{m-1}\right]^T $$
$$ z=d.*y_B $$
$$ y=\left[
		\begin{array}{c}
		y_T+z \\
		y_T-z
		\end{array}
\right] $$
&emsp;&emsp;end if <br/>
<center>
return \(y\) <br/>
</center>
&emsp;&emsp;end function <br/>

</div>

