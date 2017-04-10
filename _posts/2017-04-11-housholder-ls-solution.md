---
layout: post
title: Householder LS Solution
date: 2017-04-11 03:19
---

----------------
<div>
if \(A\in \mathbb{R}^{m\times n}\) has full column rank and \(b \in \mathbb{R}^m\), then the following algorithm computes a vector \(x_{LS}\in \mathbb{R}^n\) such that \| Ax_{LS}-b \|_2 is minimum.
<br/>
<br/>
Overwrite A with its QR factorization.<br/>
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

