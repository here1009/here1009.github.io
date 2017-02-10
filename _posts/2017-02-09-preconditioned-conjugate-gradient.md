---
layout: post
title: Preconditioned Conjugate Gradient
date: 2017-02-09 10:59
---

----------------
<div>
solve \( Ax=b \) <br/>
$$ r_{0}=b-Ax_{0} $$
$$ z_{0}=M^{-1}r_0 $$
$$ P_{0}=z_0 $$
$$ k=0 $$
loop <br/>
$$ \alpha_{k+1}=\frac{r_k^Tz_k}{P_k^TAP_k} $$
$$ x_{k+1}=x_k+\alpha_kP_k $$
$$ r_{k+1}=r_k-\alpha_kAP_k $$
if( \(r_{k+1} < \epsilon)\) exit <br/>
$$ z_{k+1}=M^{-1}r_{k+1} $$
$$ \beta_k=\frac{z_{k+1}^Tr_{k+1}}{z_k^Tr_k} $$
$$ P_{k+1}=z_{k+1}+\beta_kP_k $$
$$ k=k+1 $$
end loop <br/>
<center>
return \(x_{k+1}\)
</center>
</div>

