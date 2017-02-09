---
layout: post
title: Preconditioned Conjugate Gradient
date: 2017-02-09 10:59
---

----------------
<div font=13px>
\( r_{0}=b-Ax_{0} \) <br/>
\( z_{0}=M^{-1}r_0 \) <br/>
\( P_{0}=z_0 \)<br/>
\( k=0 \)<br/>
loop <br/>
\( \alpha_{k+1}=\frac{r_k^Tz_k}{P_k^TAP_k} \)<br/>
\( x_{k+1}=x_k+\alpha_kP_k \)<br/>
\( r_{k+1}=r_k+\alpha_kAP_k \)<br/>
</div>

