---
layout: post
title: Steepest Descent with Exact Line Search
date: 2017-02-23 22:22
---

----------------
<div>
Given a symmetric positive definite \(A \in \mathbb{R}^{n \times n}\),\(b \in \mathbb{R}^{n \times n}\),\(Ax_0 \approx b\), and a termination tolerance \(\tau\), the following algorithm produces \(x \in \mathbb{R}^n\) so that \(\| Ax-b \|_2 \le \tau\).

$$x=x_0,g=Ax-b$$
$$while \|g\|_2 > \tau$$
$$\mu=(g^Tg)/(g^TAg),x=x-ug,g=Ax-b$$
$$end$$

</div>

