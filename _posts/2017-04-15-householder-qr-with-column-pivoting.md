---
layout: post
title: Householder QR With Column Pivoting
date: 2017-04-15 22:29
---

----------------
<div>
Given \(A\in \mathbb{R}^{m\times n}\) with \(m \gt n\), then following algorithm computes \(r=rank(A)\) and the factorization with \(Q=H_1\cdots H_r\) and  \(\Pi=\Pi_1\cdots\Pi_r\). The upper triangular part of A is overwiritten by the upper tirangular part of \(R\) and components \(j+1:m\) of the \(j\)th Householder vector are stored in \(A(j+1:m,j)\). The permuation \(\Pi\) is encoded in an integer vector piv. In particular, \(\Pi_j\) is the identity with rows \(j\) and \(piv(j)\) interchanged.
 <br/>
<br/>
for \(j=1:n\)<br/>
&emsp;\(c(j)=A(1:m,j)^TA(1:m,j)\)<br/>
end<br/>
\(r=0\)<br/>
\(r=max{c(1),\cdots,c(n)}\)<br/>
while \(\tau > 0\) and \(r < n\)<br/>
&emsp;\(r=r+1\)<br/>
&emsp;Find smallest \(k\) with \(r \le k \le n\) so \(c(k)=\tau\).<br/>
&emsp;\(piv(r)=k\)<br/>
&emsp;\(A(1:m,r) \leftrightarrow A(1:m,k)\)<br/>
&emsp;\(c(r) \leftrightarrow c(k)\)<br/>
&emsp;\([v,\beta]=house(A(r:m,r))\)<br/>
&emsp;\(A(r:m,r:n)=(I_m-r+1-\beta v v^T)A(r:m,r:n)\)<br/>
&emsp;\(A(r+1:m,r)=v(2:m-r+1)\)<br/>
&emsp;for \(i=r+1:n\)<br/>
&emsp;&emsp;\(c(i)=c(i)-A(r,i)^2\)<br/>
&emsp;end<br/>
&emsp;\(\tau=max{c(r+1},\cdots,c(n)}\)<br/>
end<br/>
&emsp;<br/>
</div>

