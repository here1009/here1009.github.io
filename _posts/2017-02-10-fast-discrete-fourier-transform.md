---
layout: post
title: Fast Discrete Fourier Transform
date: 2017-02-10 24:00
---

----------------
<div>
if \( x\in \mathbb{C},\ n=2^t,\ t\in \mathbb{Z} \) <br/>
<pre>
	function fft(\(x\),\(n\)) <br/>
	  if(\(n==1\)) <br/>
</pre>
$$ y=x $$
<pre>
	  \( else \) <br/>
</pre>
$$ m=/frac{n}{2} $$
$$ y_T=fft(x(1:2:n),m) $$
$$ y_B=fft(x(2:2:n),m) $$
$$ \omega=e^\frac{-2\pi i}{n} $$
$$ d=\left[1,w,\dots,w^{m-1}\right]^T $$
$$ z=d.*y_B $$
$$ y=\left[
		\begin{array}{c}
		y_T+z \\
		y_T-z
		\end{array}
\right] $$
<pre>
	  end if <br/>
</pre>
<center>
return \(y\) <br/>
<pre>
	end function
</pre>
</center>
</div>

