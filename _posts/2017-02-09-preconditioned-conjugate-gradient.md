---
layout: post
title: Preconditioned Conjugate Gradient
date: 2017-02-09 10:59
---

----------------
<div>
$$ r_{0}=b-Ax_{0} $$
$$ z_{0}=M^{-1}r_0 $$
$$ P_{0}=z_0 $$
$$ k=0 $$
loop $$
$$ \alpha_{k+1}=\frac{r_k^Tz_k}{P_k^TAP_k} $$
$$ x_{k+1}=x_k+\alpha_kP_k $$
$$ r_{k+1}=r_k+\alpha_kAP_k $$
</div>

