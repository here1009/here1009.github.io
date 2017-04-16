---
layout: post
title: Householder QR With Column Pivoting
date: 2017-04-15 22:29
---

----------------
<div>
Given \(A\in \mathbb{R}^{m\times n}\) with \(m /gt n\), then following algorithm computes \(r=rank(A)\) and the factorization with \(Q=H_1\cdots H_r\) and  
<br/>
<br/>
Overwrite \(A\) with its QR factorization.<br/>
for \(j=1:n\)
&emsp;\(v=\left[
    \begin{array}{c}
    1\\
    A(j+1:m,j)
    \end{array}
\right]\)<br/>
&emsp;\(\beta = 2/v^Tv\) <br/>
&emsp;\(b(j:m)=b(j:m) - \beta (v^Tb(j:m))v\)<br/>
end<br/>
Solve \(R(1:n,1:n)\cdot x_{LS} = b(1:n)\)<br/>
</div>

