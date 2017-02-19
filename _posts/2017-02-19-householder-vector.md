---
layout: post
title: Householder Vector
date: 2017-02-19 20:28
---

----------------
<div>
Given \(x \in \mathbb{R}^m \), this function computes \(v \in \mathbb{R}^m\) with \(v(1)=1\) and \(\beta \in \mathbb{R} \) such that \(P=I_m-\beta v v^T\) is orthogonal and \(Px=\| x \|_2 e_1\).<br/>
<div style="padding-left:50px;padding-top:20px;">
function \([v,\beta]\)=house(\(x\)) <br/>
&emsp;\(m\)=length(\(x\)),\(\sigma=x(2:m)^Tx(2:m)\),\(v=\left[ \begin{array}{c} 1 \\ x(2:m) \end{array}\right]\)<br/>
&emsp;if \(\sigma=0\) and \(x(1)>=0\)<br/>
&emsp;&emsp;\(\beta=0\)<br/>
&emsp;elseif \(\sigma=0\) and \(x(1)<0\)<br/>
&emsp;&emsp;\(\beta=-2\)<br/>
&emsp;else<br/>
&emsp;&emsp;\(\mu=\sqrt{x(1)-\mu}\)<br/>
&emsp;&emsp;if \(x(1)<=0\)<br/>
&emsp;&emsp;&emsp;\(v(1)=x(1)-\mu\)<br/>
&emsp;&emsp;else<br/>
&emsp;&emsp;&emsp;\(v(1)=-\sigma/(x(1)+\mu\))<br/>
&emsp;&emsp;end<br/>
&emsp;&emsp;\(\beta=2v(1)^2/(\sigma+v(1)^2)\)<br/>
&emsp;&emsp;\(v=v/v(1)\)<br/>
end<br/>
</div>
</div>

