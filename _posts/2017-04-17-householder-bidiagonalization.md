---
layout: post
title: Householder Bidiagonalization
date: 2017-04-17 18:56
---

----------------
<div>
Given \(A\in \mathbb{R}^{m\times n}\) with \(m \gt n\), the following algorithm overwrites \(A\) with \(U^T_BAV_B=B\) where \(B\) is upper bidiagonal and \(U_B=U_1\cdots U_n\) and \(V_B=V_1\cdots V_{n-2}\). The essential part of \(U_j\)'s Householder vector is stored in \(A(j+1:m,j)\)  and the essential par to f \(V_j\)'s Householder vector is stored in \(A(j,j+2:n)\).
 <br/>
<br/>
for \(j=1:n\)<br/>
&emsp;\([v,\beta]=house(A(j:m,j))\)<br/>
&emsp;\(A(j:m,j:n)=(I_{m-j+1}-\beta v v^T)A(j:m,j:n)\)<br/>
&emsp;\(A(j+1:m,j)=v(2:m-j+1)\)<br/>
&emsp;if \(j \le n-2\)<br/>
&emsp;&emsp;\([v,\beta]=house(A(j:j+1,n)^T)\)<br/>
&emsp;&emsp;\(A(j:m,j+1:n)=A(j:m,j+1:n)(I_{n-j}-\beta v v^T)\)<br/>
&emsp;&emsp;\(A(j,j+2:n)=v(2:n-j)^T\)<br/>
&emsp;end<br/>
end<br/>
</div>

