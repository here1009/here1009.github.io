---
layout: post
title: Householder QR
date: 2017-03-13 22:08
---

----------------
<div>
Suppose \(Q=Q_1 \cdots Q_r\) where the \(Q_j=I_m-\beta_jv_jv_j^T\) are stored in factored form. This algorithm computes matrices \(W,Y \in \mathbb{R}^{m\times r}\) such that \(Q=I_m-WY^T\).
<br/>
<br/>
for \(j=1,n\)<br/>
&emsp;\([v,\beta]=house(A(j:m,j))\)<br/>
&emsp;\(A(j:m,j:n)=(I-\beta v v^T)A(j:m,j:n)\)<br/>
&emsp;if\(j < m\) <br/>
&emsp;\(A(j+1:m,j)=v(2:m-j+1)\)<br/>
&emsp;end<br/>
end<br/>

</div>

