---
layout: post
title: DFT Properties
date: 2017-02-11 22:03
---

----------------
<div>
1. \( N-periodic \)
   $$ X_k=\sum_{n=0}^{N-1}x_ne^{-2\pi ikn/N} $$
   $$ x_n=\frac{1}{N}\sum_{k=0}^{N-1}X_ke^{2\pi ikn/N} $$

2. Parseval
    $$ \sum_{n=0}^{N-1}x_ny_n^*=\frac{1}{N}\sum_{k=0}^{N-1}X_kY_k^*$$
    $$ \sum_{n=0}^{N-1}x_n=\frac{1}{N}\sum_{k=0}^{N-1}X_k$$
    $$ \sum_{n=0}^{N-1}|x_n|^2=\frac{1}{N}\sum_{k=0}^{N-1}|X_k|^2$$

3. Convolution
    $$ A_k*B_k=\sum_{l=0}^{N-1}A_lB_{k-l}\simx_jy_j $$
    $$ A_kB_k\sim\frac{1}{N}\sum_{l=0}^{N-1}x_ly_{j-l}$$

</div>

