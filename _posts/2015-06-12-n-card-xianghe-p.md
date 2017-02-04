---
layout: post
title: 两副相同的牌各N张随意配对有m个相合的概率$$P_{[m]}$$
date: 2015-06-12 22:39
---

<!-- * 目录
{:toc} -->
[TOC]

#h1
##sdfdsf

相合:对应的两张牌相同
  
----------------

$$
P_{[0]}=1-1+\frac{1}{2!}-\frac{1}{3!}+\dots\pm\frac{1}{(N-2)!}\mp\frac{1}{(N-1)!}\pm\frac{1}{N!}
$$

<img src="http://www.forkosh.com/mathtex.cgi? 
 P_{[1]}=1-1+\frac{1}{2!}-\frac{1}{3!}+\dots\pm\frac{1}{(N-2)!}\mp\frac{1}{(N-1)!}
">

<img src="http://www.forkosh.com/mathtex.cgi? 
P_{[2]}=\frac{1}{2!}\{1-1+\frac{1}{2!}-\frac{1}{3!}+\dots\mp\frac{1}{(N-3)!}\pm\frac{1}{(N-2)!}\}
">

<img src="http://www.forkosh.com/mathtex.cgi? 
P_{[3]}=\frac{1}{3!}\{1-1+\frac{1}{2!}-\frac{1}{3!}+\dots\mp\frac{1}{(N-3)!}\}
">

<img src="http://www.forkosh.com/mathtex.cgi? 
\dots\dots\dots\dots\dots\dots\dots\dots
">

<img src="http://www.forkosh.com/mathtex.cgi? 
P_{[N-2]}=\frac{1}{(N-2)!}\{1-1+\frac{1}{2!}\}
">

<img src="http://www.forkosh.com/mathtex.cgi? 
P_{[N-1]}=\frac{1}{(N-1)!}\{1-1\}=0
">

<img src="http://www.forkosh.com/mathtex.cgi? 
P_{[N]}=\frac{1}{(N)!}
">

```c
#include <stdio.h>
int main(){
	printf("hello");
	return 0;
}
```
