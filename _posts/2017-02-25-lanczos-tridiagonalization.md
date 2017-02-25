---
layout: post
title: Lanczos Tridiagonalization 
date: 2017-02-25 21:45
---

----------------
<div>
Given a symmetric matrix \(A \in \mathbb{R}^{n\times n}\) and a unit 2-norm vector \(q_1\in \mathbb{R}^n\), the following algorithm computes a matrix \(Q_k=[q_1|\cdots|q_k]\) with orthnormal column and a tridiagonal matrix \(T_k \in \mathbb{R}^{k\times k}\) so that \(AQ_k=Q_kT_k\). The diagonal and superdiagonal entries of \(T_k\) are \(\alpha_1,\cdots,\alpha_k\) and \(\beta_1,\cdots,\beta_k-1\) respectively. The integer k satisfies \(1 \le k \le n\).
<br/>
<br/>
\(k=0,\beta_0=1,q_0=0,r_0=q_1\)<br/>
while \(k=0\) or \(\beta_k \ne 0\)<br/>
&emsp;\(q_{k+1}=r_k/\beta_k\)<br/>
&emsp;\(k=k+1\)<br/>
&emsp;\(\alpha_k=q_k^TAq_k\)<br/>
&emsp;\(r_k=(A-\alpha_kI)q_k-\beta_{k-1}q_{k-1}\)<br/>
&emsp;\(\beta_k=\|r_k\|_2\)<br/>
end<br/>

</div>

