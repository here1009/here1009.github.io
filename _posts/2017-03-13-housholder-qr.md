---
layout: post
title: Householder QR
date: 2017-03-13 22:08
---

----------------
<div>
Given \(A\in\mathbb{R}^{m\times n}\) with \(m\gt n\), the following alogorithm finds Householder matrices \(H_1,\cdots,\H_n\) such that if \(Q=H_1\cdot\cdot\cdot H_n\), then \(Q^TA=R\) is upper triangular. The upper triangular part of \(A\) is overwritten by the upper triangular part of \(R\) and components \(j+1:m\) of the jth Householder vector are stored in \(A(j+1:m,j)\),\(j<m\).<br/>
<br/>
for \(j=1,n\)<br/>
&emsp;\([v,\beta]=house(A(j:m,j))<br/>
&emsp;\(A(j:m,j:n)=(I-\beta v v^T)A(j:m,j:n)\)<br/>
&emsp;if\(j < m\) <br/>
&emsp;\(A(j+1:m,j)=v(2:m-j+1)\)<br/>
&emsp;end<br/>
end<br/>

</div>

