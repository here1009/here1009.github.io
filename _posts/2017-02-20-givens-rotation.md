---
layout: post
title: Givens Rotation
date: 2017-02-20 22:00
---

----------------
<div>
Given scalars a and b, this function computes \(c=cos(\theta)\) and \(s=sin(\theta)\) so
$$
\left[
    \begin{array}{cc}
    c & s\\
    -s & c
    \end{array}
\right]
\left[
    \begin{array}{c}
    a\\
    b
    \end{array}
\right]=
\left[
    \begin{array}{c}
    r\\
    0
    \end{array}
\right]
$$
<div style="padding-left:50px;padding-top:20px;">
function \([c,s]\)=givens(a,b) <br/>
&emsp;if \(b=0\)<br/>
&emsp;&emsp;\(c=1\);\(s=0\)<br/>
&emsp;else<br/>
&emsp;&emsp;\(\beta=-2\)<br/>
&emsp;else<br/>
&emsp;&emsp;if \(|b|>|a|\)<br/>
&emsp;&emsp;&emsp;\(r=-a/b; s=1/\sqrt{1+\tau^2};c=s\tau\)<br/>
&emsp;&emsp;else<br/>
&emsp;&emsp;&emsp;\(r=-b/a; c=1/\sqrt{1+\tau^2};s=c\tau\)<br/>
&emsp;&emsp;end<br/>
&emsp;end<br/>
</div>
</div>

