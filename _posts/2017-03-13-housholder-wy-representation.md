---
layout: post
title: Householder Matrix WY Representation
date: 2017-03-20 23:17
---

----------------
<div>
Suppose \(Q=Q_1 \cdots Q_r\) where the \(Q_j=I_m-\beta_jv_jv_j^T\) are stored in factored form. This algorithm computes matrices \(W,Y \in \mathbb{R}^{m\times r}\) such that \(Q=I_m-WY^T\).
<br/>
<br/>
\(Y=v_1\); \(W=\beta_1v_1\)<br/>
for \(j=2:r\)<br/>
&emsp;\(z=\beta_j(I_m-WY^T)v_j\)<br/>
&emsp;\(W=[W | z]\) <br/>
&emsp;\(Y=[Y | v_j]\)<br/>
end<br/>

</div>

