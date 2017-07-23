---
layout: wpost
title: PWMAT
---

[Homepage](http://www.pwmatus.com)

# 0. PWmat

# 1. JOB=TDDFT

## support:

- xcfunctional=lda/pbe

- **norm** conserving psedupotential

# 2. TDDFT_DETAIL=m1 m2 mstate
## default: 
> TDDFT_DETAIL=1 NUM_BAND NUM_BAND
## **description:**
> Expand `$ \psi_j(t) $` in terms of the adiabatic eigenstates `$\phi_i(t)$`:
>
```math
\psi_j(t)=\sum_i C_{ji}(t)\phi_i(t)
```
> Define the Adiabatic window [m1,m2],
>
```math
\psi_j(t)=\phi_j(t), j=1,m1-1
```
```math
\psi_j(t)=\sum_i C_{ji}(t)\phi_i(t), j=m1,mstate;i=m1,m2
```
>
 |  | | | | 
---|---|---|---|---|----
`$[m1,m2]$` | Adiabatic window, the `$[1,m1-1]$` will always be occupied by the first`$\psi_{j,j=1,m1-1}$` states.  | `$\phi_i,{i=m1,m2}$`  | `$m2\in [m1,NUM\_BAND]$`
[1,msate] | Wavefunction index | `$\psi_j,j=1,mstate$`| `$mstate\in [m1,m2]$` |

> *usually m2 is smaller than NUM_BAND by a few states, cause the last few states maybe not converged well.

## how to choose the parameters: 

 | | |
---|---
`$[m1,m2]$`|  
`$mstate$` |

## example1--default settings
- **atom.config:**
```
 8
Lattice vector
    5.65      0.00      0.00
    0.00      5.65      0.00
    0.00     0.00      5.65
Position, move_x, move_y, move_z
31    0.001000000000    0.000000000000    0.000000000000  1  1  1   1.0
31    0.000000000000    0.501000000000    0.502000000000  1  1  1   1.0
31    0.500000000000    0.000000000000    0.500000000000  1  1  1   1.0
31    0.500000000000    0.500000000000    0.000000000000  1  1  1   1.0
33    0.250000000000    0.250000000000    0.250000000000  1  1  1   0.0
33   -0.250000000000   -0.250000000000    0.250000000000  1  1  1   0.0
33   -0.250000000000    0.250000000000   -0.250000000000  1  1  1   0.0
33    0.250000000000   -0.250000000000   -0.250000000000  1  1  1   0.0
```
- **default settings:**

```
1           1
IN.ATOM   = atom.config
JOB       = TDDFT
MD_DETAIL = 1, 200, 0.1, 300,300
IN.PSP1   = 31-Ga.LDA.fhi.UPF
IN.PSP2   = 33-As.LDA.fhi.UPF
```

- **Etot,Ek,Ep plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/1.png?raw=true)

## example2--use adiabatic window
>from the output file OUT.OCC of example1

```
KPOINTS   1:    0.0000    0.0000    0.0000
NO.   ENERGY(eV) OCCUPATION
 1    -10.7422   2.00000
 2     -8.3784   2.00000
 3     -8.2272   2.00000
 4     -8.1217   2.00000
 5     -5.0553   2.00000
 6     -5.0473   2.00000
 7     -5.0042   2.00000
 8     -0.8431   2.00000
 9     -0.8061   2.00000
10     -0.7368   2.00000
11     -0.7011   2.00000
12     -0.6666   2.00000
13     -0.6165   2.00000
14      1.8319   1.99983
15      2.0285   1.99966
16      2.1978   1.99956
17      2.4204   0.00095
18      3.0161   0.00000
19      3.0985   0.00000
20      3.2698   0.00000
21      3.3809   0.00000
22      3.4191   0.00000
23      3.5045   0.00000
24      5.4035   0.00000
25      5.5223   0.00000
26      5.6578   0.00000
```
> we know that the `$[1,16]$` states are occupied, and total num of band is 26. Then we can set the TDDFT_DETAIL=m1 m2 mstate,`$m1 \in [1,16]$`, `$m2 \in [m1,26]$`, `$mstate \in [m1,m2]$`


```
1           1
IN.ATOM   = atom.config
JOB       = TDDFT
precision=double
convergence=difficult
MD_DETAIL = 1, 200, 0.1, 300,300
TDDFT_DETAIL=6,26,23
IN.PSP1   = 31-Ga.LDA.fhi.UPF
IN.PSP2   = 33-As.LDA.fhi.UPF
```
- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/2.png?raw=true)

# 3.OUT.TDDFT=T1 T2 n1 T3 n2
## default: 
>OUT.TDDFT=F F 100 F 100
## description:
>The output files can be used to restart TDDFT and show the process of TDDFT.


 | | | | | |
|:---|:---|:---|:---|:---|
`$T1,T2,n1$` | `$T1=T/F$` |eigen energy, dipole, `$occ(i)$` per n1 steps|the output will be in file OUT.TDDFT1, MDDIPOLE.RSPACE. One can use plot_TDDFT.f to read and output OUT.TDDFT1.|
| | `$T2=T/F$`|`$C_{ij}$` per n1 steps|
`$T3,n2$`|`$T3=T/F$`|output all the wavefunctions and charge densities per n2 steps for restart.|the output will be in file OUT.TDDFT,OUT.WG,OUT.RHO and directory TDDOS/. This can be very expensive, so use large n2.

## example3:OUTPUT FILES

```
   1           1
IN.ATOM   = atom.config     
JOB       = TDDFT
MD_DETAIL = 1, 200, 0.1, 300,300
IN.PSP1   = 31-Ga.LDA.fhi.UPF
IN.PSP2   = 33-As.LDA.fhi.UPF
Ecut      =    30
N123      =    32    32    32
OUT.TDDFT = T T 10 T  50
```
- **ls**

|||||
---|---|---|---
./|OUT.TDDFT1|update per 10 steps|used by plot_TDDFT.f90
./|OUT.WG,OUT.RHO,OUT.TDDFT|update per 50 steps|used by restarting TDDFT|
TDDOS|OUT.WG.\*,TDEIGEN.\*,OUT.EIGEN.\*|update per 50 steps|used by ploting DOS

# 4.TDDFT_SPACE=itype1, N, a(1),...,a(N)
## default:
> TDDFT_SPACE=0 N a(1) ... a(N)
## description:
> This controls the real space Vext_tddft(r). Vext_tddft(r) refers to the  external potential in real space for tddft calculation.

|||
---|---|
|`$itype1$` | |
|`$0$`|no external input term.|
|`$1$`|read vext_tddft from file IN.VEXT_TDDFT(all capital, same format as in IN.VEXT)
|`$2$`|`$Vext\_tddft(r)=(x-x_0)a(1)+(x-x_0)^2a(2)+(y-y_0)a(3)+(y-y_0)^2a(4)+(z-z_0)a(5)+(z-z_0)^2a(6)$`, (`$ x_0 $`,`$y_0$`,`$z_0$`) is center of AL box.all a(i) atomic unit. output file OUT.VEXT_TDDFT
|`$3$`|`$Vext\_tddft(r)=a(1)e^{-[(x-x_0)^2+(y-y_0)^2+(z-z_0)^2]/a(2)^2}$`.a(1) Hartree unit, a(2) Bohr unit. output file OUT.VEXT_TDDFT
|`$-1$`|Not use real space format, but use G-space,it wil use IN.A_FIELD

## example6: itype1=1
>first we can get IN.VEXT_TDDFT by set ityp1=2. [`$Vext\_tddft(r)=(x-x0)*0.002 $`]


```
 1           1
 IN.ATOM   = atom.config       
 JOB       = TDDFT
 precision = double
 convergence=difficult
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = 2, 6, 0.002,0.0,0.0,0.0,0.0,0.0
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 num_band  =  30
 Ecut      =   30.0
 N123     = 32 32 32
```

```
 cp OUT.VEXT_TDDFT IN.VEXT_TDDFT
```

```
 1           1
 IN.ATOM   = atom.config       
 JOB       = TDDFT
 precision = double
 convergence=difficult
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = 1, 6, 0.002,0.0,0.0,0.0,0.0,0.0
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 num_band  =  30
 Ecut      =   30.0
 N123     = 32 32 32
```
- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/6.png?raw=true)

## example7: itype1=2
itype1=2.[`$Vext\_tddft(r)=(x-x_0)*0.002+(x-x_0)^2*0.001$`]

```
1           1
 IN.ATOM   = atom.config       
 JOB       = tddft 
 precision = double
 convergence=difficult
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = 2, 6, 0.002,0.001,0.0,0.0,0.0,0.0
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 num_band  =  30
 Ecut      =   30.0
 N123     = 32 32 32
```
- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/7.png?raw=true)

## example8: itype1=3
itype1=3.[`$Vext\_tddft(r)=1.0*e^{-[(x-x_0)^2+(y-y_0)^2+(z-z_0)^2]/2.0^2}$`]
 
```
1           1
 IN.ATOM   = atom.config       
 JOB       = tddft 
 precision = double
 convergence=difficult
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = 3, 2, 1.0,2.0
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 num_band  =  30
 Ecut      =   30.0
 N123     = 32 32 32
```
- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/8.png?raw=true)

## itype1=-1. ref. IN_A.FIELD.

# 5.IN.A_FIELD=T/F,a_field1,a_field2,a_field3
## default: 
> IN.A_FIELD=F 0.0 0.0 0.0
## description:
> This controls the G-sapce external potential input for tddft calculation.(only used when TDDFT_SPACE=-1,...;)
> the tddft hamiltonian 

```math
H=-1/2 (\nabla_x + i a\_field1)^2-1/2(\nabla_y+ i a\_field2)^2-1/2(\nabla_z + i a\_field3)^2
```

## example9:IN.A_FIELD

```
1           1
 IN.ATOM   = atom.config
 #precision = double
 JOB       = TDDFT
 precision = double
 convergence=difficult
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = -1,6, 0.002,0,0.,0, 0., 0
 IN.A_FIELD = T  0.1 0.2 0.3 
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
```

- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/9.png?raw=true)

# 6.TDDFT_TIME=itype2,N,b(1),...,b(N)
## default: 
> TDDFT_TIME=0 N b(1) ... b(N)
## description:
> This is used to control the time dimension of the external function fTDDFT(i).

|||
---|---
`$ityp2$`|
0|`$ftddft(t)=1.0$`
1|read in `$ftddft(i)$` from IN.TDDFT_TIME
2|`$ftddft(t)=b(1)e^{-(t-b(2))^2/b(3)^2)}\sin(b(4)t+b(5))$`,`$b(2)$`,`$b(3)$` fs unit,output OUT.TDDFT_TIME

>file IN.TDDFT_TIME likes:

```
0 ftddft(0)
1 ftddft(1)
...
N ftddft(N)
```
>For TDDFT Hamiltonian, we have:

|||
---|---
`$ityp1$`|
`$\ne -1$`| `$H(t)=H_0+Vext\_tddft(r)ftddft(t)$`
`$-1$`| `$H(t)=-1/2(\nabla_x+i A_x*ftddft(t))-1/2(\nabla_y+i A_y*ftddft(t))^2-1/2(\nabla_z+i A_z*ftddft(t))^2$`

## example10:itype1=2,itype2=1.
 
```
1           1
 IN.ATOM   = atom.config
 JOB       = TDDFT
 precision = double
 convergence=difficult
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = 2, 6, 0.002,0,0.,0, 0., 0
 TDDFT_TIME = 1, 5, 1.d0,5.,3., 1.5, 0.0
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
```
> IN.TDDFT_TIME
     
```
           0  0.000000000000000E+000
           1  1.037194639886028E-002
           2  2.284511287170516E-002
           3  3.736828505828689E-002
           4  5.378968011195755E-002
           5  7.184419673777015E-002
           6  9.114384810445718E-002
           7  0.111172445929042     
           8  0.131285553886038     
           9  0.150716610764225     
          10  0.168589934786881     
          ....
         195 -5.921998502932264E-011
         196 -4.671431218955184E-011
         197 -3.575974730194868E-011
         198 -2.664695193942652E-011
         199 -1.936043364608484E-011
         200 -1.372172773221090E-011
```
- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/10.png?raw=true)

## example11:itype1=2,itype2=2.

```
1           1
 IN.ATOM   = atom.config
 JOB       = TDDFT
 precision = double
 convergence=difficult
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = 2, 6, 0.002,0,0.,0, 0., 0
 TDDFT_TIME = 2, 5, 2.d0,5.,3., 1.5, 0.0
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
```

- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/11.png?raw=true)

## example12:itype1=-1,itype2=2.

```
1           1
 IN.ATOM   = atom.config
 JOB       = TDDFT
 precision = double
 convergence=difficult
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = -1, 6, 0.002,0,0.,0, 0., 0
 IN.A_FIELD = T  0.1 0.0 0.0 
 TDDFT_TIME = 2, 5, 2.d0,5.,3., 1.5, 0.0
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
```

- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/12.png?raw=true)

# 7.IN.OCC/IN.OCC_2
## description:
> The files are used to set the ocupation of adiabatic eigenstates when FERMI-DIRAC=0.
> 
> spin=1, use IN.OCC
> spin=2, use both IN.OCC and IN.OCC_2 

> File IN.OCC likes:

```
1.0 1.0 1.0 0.6 0.0 0.0 0.0 ... #occupations for k-point1
1.0 1.0 1.0 0.6 0.0 0.0 0.0 ... #occupations for k-point2
....
```

## example13:IN.OCC

```
1           1
 IN.ATOM   = atom.config
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 precision = double
 convergece=difficult
 JOB       = TDDFT
 MD_DETAIL = 1, 20, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = -1,6, 0.002,0,0.,0, 0., 0
 IN.A_FIELD = T  0.1 0.0 0.0
 TDDFT_TIME = 2, 5, 1.d0,5.,3., 1.5, 0.0
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
 SCF_ITER0_1 =    6   4    3    0.0000     0.02500   0
 SCF_ITER0_2 =   94   4    3    1.0000     0.02500   0
```

> IN.OCC

```
1 1 1 1 1 1 1 1 1 1  
 1 1 1 0.66666666666666
 0.66666666666666 0.66666666666666 1
 0 0 0 0 0 0 0 0 0 0 0 0 0
```
 
- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/13.png?raw=true)

# 8.IN.CC/IN.CC_2

## descrition:
> The files are used to initialize the `$C_{ij}$` for TDDFT when **FREMI-DIRAC=-1**, which is used as `$\psi_j(t)=\sum_i C_{ji}(t)\phi_i(t)$`.
> 
> spin=1, use IN.CC
> spin=2, use both IN.CC and IN.CC_2

> File IN.CC likes:

```
1  1  1.0
1  2  1.0
1  3  1.0
2  4  0.8  5 0.2
1  5  1.0
....
```

> Line `$j$` specify the `$\psi_j, j=1,mstate$`.
> Define pair (i,CC), `$i$` is the index of adiabatic states, CC is the value of `$C_{ji}$`.
> The first column specify the number of pairs.
> If m, one index of adiabatic states, is not specified , then `$C_{jm}=0$`.

## example14:IN.CC
 
```
1           1
 IN.ATOM   = atom.config
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 precision = double
 convergece=difficult
 JOB       = TDDFT
 MD_DETAIL = 1, 20, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = -1,6, 0.002,0,0.,0, 0., 0
 IN.A_FIELD = T  0.1 0.0 0.0
 TDDFT_TIME = 2, 5, 1.d0,5.,3., 1.5, 0.0
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
 SCF_ITER0_1 =    6   4    3    0.0000     0.02500   -1
 SCF_ITER0_2 =   94   4    3    1.0000     0.02500   -1
```

> IN.OCC

```
1 1 1 1 1 1 1 1 1 1  
 1 1 1 0.66666666666666
 0.66666666666666 0.66666666666666 1
 0 0 0 0 0 0 0 0 0 0 0 0 0
```

> IN.CC    
  
```
1  1 1.0   
  1  2 1.0
  1  3 1.0
  1  4 1.0
  1  5 1.0
  1  6 1.0
  1  7 1.0
  1  8 1.0
  1  9 1.0
  1  10 1.0
  1  11 1.0
  1  12 1.0
  1  13 1.0  
  1  14 1.0  
  1  15 1.0  
  2  16 0.8  17 0.2
  1  17 1.0  
  1  18 1.0  
  1  19 1.0  
  1  20 1.0  
  1  21 1.0  
  1  22 1.0  
  1  23 1.0  
  1  24 1.0  
  1  25 1.0  
  1  26 1.0  
  1  27 1.0  
  1  28 1.0  
  1  29 1.0  
  1  30 1.0
```

- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/14.png?raw=true)

# 9.MD_DETAIL = MD, MSTEP, DT, TEMP1, TEMP2
## default: 
> no default setting.
## description:
> Note: this is a required line for JOB=MD and JOB=TDDFT. (ref. PWmat manual 2.1.6.)
# 10.TDDFT_STIME=stime
## description:
> stime used for restart TDDFT, is the starting time of TDDFT. fs unit.
> see RESTART.
# 11.RESTART
## description:
> needed settings: 

```
MD_DETAIL=11,...
IN.RHO=T
IN.WG=T 
TDDFT_STIME=stime
```
 
> needed files:

|||
---|---
`$spin$`|IN.ATOM=atom.config from MOVEMENT
`$1,22$`|OUT.WG-->IN.WG;OUT.RHO-->IN.RHO;OUT.TDDFT-->IN.TDDFT
`$2$`|OUT.WG-->IN.WG;OUT.RHO-->IN.RHO:OUT.WG_2-->IN.WG_2:OUT.RHO_2-->IN.RHO_2:OUT.TDDFT-->IN.TDDFT"
`$222$`|OUT.WG-->IN.WG;OUT.RHO-->IN.RHO;OUT.RHO_SOM-->IN.RHO_SOM;OUT.TDDFT-->IN.TDDFT

## example4:RESTART
> One TDDFT. killed at 329 step.
     
```
1           1
  IN.ATOM   = atom.config     
  JOB       = TDDFT
  MD_DETAIL = 1, 1000, 0.1, 300,300
  IN.PSP1   = 31-Ga.LDA.fhi.UPF
  IN.PSP2   = 33-As.LDA.fhi.UPF
  Ecut      =    30
  N123      =    32    32    32
  OUT.TDDFT = T T 100 T  100
```
> Files we get:

|||
---|---
OUT.WG,OUT.RHO,OUT.TDDFT|of step 300
MOVEMENT,MDSTEPS|each step

- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/4.png?raw=true)

> Resart TDDFT from step 300.
 
```
1           1
 IN.ATOM   = atom.config.300    
 JOB       = TDDFT
 MD_DETAIL = 11, 1000, 0.1, 300,300
 TDDFT_STIME = 30.10
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 Ecut      =    30
 N123      =    32    32    32
 IN.WG     = T
 IN.RHO    = T
```

> get atom.config.300 from MOVEMENT:
 
```
8 atoms,Iteration=  300, Etot,Ep,Ek=   -0.9342598856E+03  -0.9344282212E+03   0.6186218552E-02
 Lattice vector
   0.5650000000E+01    0.0000000000E+00    0.0000000000E+00
   0.0000000000E+00    0.5650000000E+01    0.0000000000E+00
   0.0000000000E+00    0.0000000000E+00    0.5650000000E+01
 Position, move_x, move_y, move_z
  31   -0.002650892   -0.001549781    0.011701363     1  1  1
  31   -0.001826470    0.515825032    0.496601858     1  1  1
  31    0.488596782   -0.003825035    0.504426022     1  1  1
  31    0.512901546    0.489831560    0.011845858     1  1  1
  33    0.239192635    0.257254096    0.240225612     1  1  1
  33   -0.259114091   -0.256079157    0.251123637     1  1  1
  33   -0.236278788    0.244572796   -0.256805443     1  1  1
  33    0.259907060   -0.245082351   -0.255548664     1  1  1
 Force
  31   -0.096760713    0.083896371    0.811411472
  31   -0.306358278    0.454455044   -0.165768770
  31   -0.457764036   -0.668564451    0.440678002
  31    0.270932363    0.190182527    1.051391132
  33    0.145648837   -0.242459725   -0.535882141
  33    0.320371309   -0.343051872   -0.525941728
  33   -0.006120575    0.196394131   -0.248770888
  33    0.133291806    0.338118523   -0.829419823
 Velocity
  31   -0.001058344   -0.000666545    0.001646305
  31    0.000164137    0.003853948   -0.001632847
  31   -0.002791301    0.000563892    0.000291948
  31    0.003814745   -0.004180976    0.001003179
  33   -0.004180128    0.003104497   -0.001841969
  33   -0.004002909   -0.001311052    0.001932642
  33    0.004825449   -0.002372473   -0.001588050
  33    0.003241180    0.000975878    0.000279484
```


> get IN.RHO IN.WG IN.TDDFT

```
cp OUT.RHO IN.RHO
cp OUT.WG IN.WG
cp OUT.TDDFT IN.TDDFT
```

- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/4_2.png?raw=true)

## example15: restart with external potential.
> One TDDFT,killed at 352 step.

```
1           1
 IN.ATOM   = atom.config
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 precision = double
 convergece=difficult
 JOB       = TDDFT
 MD_DETAIL = 1, 1000, 0.01, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = -1,6, 0.002,0,0.,0, 0., 0
 IN.A_FIELD = T  0.1 0.0 0.0
 TDDFT_TIME = 2, 5, 1.d0,5.,3., 1.5, 0.0
 OUT.TDDFT = T T 100 T 100
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
```

- **Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/5.png?raw=true)

> Resart TDDFT from step 300.

```
1           1
 IN.ATOM   = atom.config.300
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 precision = double
 convergece=difficult
 JOB       = TDDFT
 MD_DETAIL = 11, 1000, 0.01, 300,300
 TDDFT_STIME=3.01
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = -1,6, 0.002,0,0.,0, 0., 0
 TDDFT_TIME = 2, 5, 1.d0,5.,3., 1.5, 0.0
 XCFUNCTIONAL = PBE
 IN.A_FIELD = T  0.1 0.0 0.0 
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
 IN.WG=T
 IN.RHO=T
```

- ** Etot,Ep,Ek plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/5_2.png?raw=true)

# 13.SHOW_RESULTS
> OUT.TDDFT---plot_tddft.f90
## example16: plot_tddft
 
```
1           1
 IN.ATOM   = atom.config.300
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 precision = double
 convergece=difficult
 JOB       = TDDFT
 MD_DETAIL = 1, 20, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 TDDFT_SPACE = -1,6, 0.002,0,0.,0, 0., 0
 IN.A_FIELD = T  0.1 0.0 0.0 
 TDDFT_TIME = 2, 5, 1.d0,5.,3., 1.5, 0.0
 OUT.TDDFT = T T 5 T 10
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
```


> plot_TDDFT.f90 & OUT.TDDFT1

```
TDDFT/example16:gfortran plot_TDDFT.f90 -o plot_TDDFT.x
TDDFT/example16:./plot_TDDFT.x
```

 
```
there is Cmat, plot E,DOS (1) or Cmat(2)
1
 there are nkpt,islda spin           1           1
 input ikpt,iislda to plot
1,1
 total num_state=          30
 input a window [mst1,mst2] to plot
6,10
 E and DOS in  plot.TDDFT.E, plot.TDDFT.DOS
 ------------------------------------------------
TDDFT/example16:vi plot.TDDFT.DOS 
TDDFT/example16:./plot_TDDFT.x 
 there is Cmat, plot E,DOS (1) or Cmat(2)
2
 there are nkpt,islda spin           1           1
 input ikpt,iislda to plot
1,1
 there are           30  psi_j(t) in Cmat(i,j)
 input one j to plot
10
 there are           30  adiabatic state phi_i(t)in Cmat(i,j)
 input a window [mst1,mst2] to plot
4 16
 Cmat is written in plot.TDDFT.Cmat
```


> TDDOS/---density of adiabatic sates
## example17:TDDOS
 
```
1           1
 IN.ATOM   = atom.config
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 precision = double
 convergece=difficult
 JOB       = tddft
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 OUT.TDDFT = T T 5 T 20
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
 SCF_ITER0_1 =    6   4    3    0.0000     0.02500    0
 SCF_ITER0_2 =   94   4    3    1.0000     0.02500    0
```

> IN.OCC

```
1 1 1 1 1 1 1 1 1 1  
 1 1 1 0 1 1
 0 0 0 0   
 0 0 0 1 0 0 0 0 0 0
```


> ls TDDOS/:
O
```
UT.EIGEN.0.100000   OUT.EIGEN.14.000000  OUT.EIGEN.2.000000   OUT.EIGEN.6.000000  OUT.WG.10.000000  OUT.WG.16.000000  OUT.WG.20.000000  OUT.WG.8.000000    TDEIGEN.12.000000  TDEIGEN.18.000000  TDEIGEN.4.000000
OUT.EIGEN.10.000000  OUT.EIGEN.16.000000  OUT.EIGEN.20.000000  OUT.EIGEN.8.000000  OUT.WG.12.000000  OUT.WG.18.000000  OUT.WG.4.000000   TDEIGEN.0.100000   TDEIGEN.14.000000  TDEIGEN.2.000000   TDEIGEN.6.000000
OUT.EIGEN.12.000000  OUT.EIGEN.18.000000  OUT.EIGEN.4.000000   OUT.WG.0.100000     OUT.WG.14.000000  OUT.WG.2.000000   OUT.WG.6.000000   TDEIGEN.10.000000  TDEIGEN.16.000000  TDEIGEN.20.000000  TDEIGEN.8.000000
```


> we can use OUT.EIGEN.* , OUT.WG.* to run JOB=DOS with PWmat.
> eg.

```
cp OUT.EIGEN.0.100000 OUT.EIGEN
cp OUT.WG.0.100000 IN.WG
```

> etot.input for DOS [the job=dos will read OUT.EIGHEN implicitly]:
 
```
1           1
 IN.ATOM   = atom.config
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 precision = double
 convergece=difficult
 JOB       = dos 
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 OUT.TDDFT = T T 5 T 20
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
 in.wg=t
```


- **dos plot:**
> we get file DOS.totalspin.

```
plot "DOS.totalspin" u 1:2 w l
```
![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/17.png?raw=true)

> use TDDOS_OCC=1 T, we will get occupied DOS.
> [the 1 of TDDOS_OCC means the OUT.EIGEN comes from TDDOS/]

> etot.input.dos.occ
 
```
1           1
 IN.ATOM   = atom.config
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 precision = double
 convergece=difficult
 JOB       = dos 
 MD_DETAIL = 1, 200, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 OUT.TDDFT = T T 5 T 20
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
 in.wg=t
 TDDOS_OCC=1 T
```

```
gnuplot> plot "DOS.totalspin.occ" u 1:($2) w filledcurve lc rgb "blue" title "DOS.occ"
gnuplot> replot "DOS.totalspin.tot" u 1:2 w l lc rgb "grey" title "DOS"
```

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/17_2.png?raw=true)

> If plot all the DOS per 20 steps, we get:

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/17_3.png?raw=true)

> MDDIPOLE.RSPACE 
## example18:MDDIPOLE

```
1           1
 IN.ATOM   = atom.config
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 precision = double
 convergece=difficult
 JOB       = tddft 
 MD_DETAIL = 1, 1000, 0.01, 300,300
 TDDFT_DETAIL = 1,30,30
 OUT.TDDFT = T T 5 T 20
 XCFUNCTIONAL = PBE
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
 SCF_ITER0_1 =    6   4    3    0.0000     0.02500    0
 SCF_ITER0_2 =   94   4    3    1.0000     0.02500    0
```


> file MDDIPOLE.RSAPECE:

```
TIME,TotalCharge,DipoleXYZ=  0.100000E-01  0.320000E+02 -0.364674E+01 -0.371733E+01 -0.383196E+01
TIME,TotalCharge,DipoleXYZ=  0.200000E-01  0.320000E+02 -0.297416E+01 -0.424450E+01 -0.393506E+01
TIME,TotalCharge,DipoleXYZ=  0.300000E-01  0.320000E+02 -0.297685E+01 -0.424519E+01 -0.393360E+01
TIME,TotalCharge,DipoleXYZ=  0.400000E-01  0.320000E+02 -0.297806E+01 -0.424629E+01 -0.393082E+01
TIME,TotalCharge,DipoleXYZ=  0.500000E-01  0.320000E+02 -0.297986E+01 -0.424880E+01 -0.392796E+01
....
```

- **plot:**

![image](https://github.com/here1009/here1009.github.io/blob/master/images/plots/18.png?raw=true)

# 14.影响稳定性的因素（参数调节）

> accuracy & precision.
## example5:accuracy & precision
>etot.input.lowprec
 
```
1           1
 IN.ATOM   = atom.config   
 JOB       = TDDFT
 MD_DETAIL = 1, 20, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 XCFUNCTIONAL = PBE
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
```

>  MDSTEPS.lowprec

```
Iter=  0.100000E+00 Etot,Ep,Ek=   -0.9362093590E+03  ..... Fcheck= -.120E+01
Iter=  0.200000E+00 Etot,Ep,Ek=   -0.9362093489E+03  ..... Fcheck= 0.704E+00
Iter=  0.300000E+00 Etot,Ep,Ek=   -0.9362093460E+03  ..... Fcheck= 0.911E+00
Iter=  0.400000E+00 Etot,Ep,Ek=   -0.9362093497E+03  ..... Fcheck= 0.111E+01
Iter=  0.500000E+00 Etot,Ep,Ek=   -0.9362093568E+03  ..... Fcheck= 0.119E+01
Iter=  0.600000E+00 Etot,Ep,Ek=   -0.9362093388E+03  ..... Fcheck= 0.717E+00
Iter=  0.700000E+00 Etot,Ep,Ek=   -0.9362093419E+03  ..... Fcheck= 0.107E+01
Iter=  0.800000E+00 Etot,Ep,Ek=   -0.9362093367E+03  ..... Fcheck= 0.920E+00
Iter=  0.900000E+00 Etot,Ep,Ek=   -0.9362093433E+03  ..... Fcheck= 0.111E+01
Iter=  0.100000E+01 Etot,Ep,Ek=   -0.9362093398E+03  ..... Fcheck= 0.955E+00
Iter=  0.110000E+01 Etot,Ep,Ek=   -0.9362093479E+03  ..... Fcheck= 0.111E+01
Iter=  0.120000E+01 Etot,Ep,Ek=   -0.9362093371E+03  ..... Fcheck= 0.888E+00
Iter=  0.130000E+01 Etot,Ep,Ek=   -0.9362093286E+03  ..... Fcheck= 0.913E+00
Iter=  0.140000E+01 Etot,Ep,Ek=   -0.9362093363E+03  ..... Fcheck= 0.109E+01
Iter=  0.150000E+01 Etot,Ep,Ek=   -0.9362093373E+03  ..... Fcheck= 0.101E+01
Iter=  0.160000E+01 Etot,Ep,Ek=   -0.9362093391E+03  ..... Fcheck= 0.102E+01
Iter=  0.170000E+01 Etot,Ep,Ek=   -0.9362093416E+03  ..... Fcheck= 0.103E+01
Iter=  0.180000E+01 Etot,Ep,Ek=   -0.9362093388E+03  ..... Fcheck= 0.974E+00
Iter=  0.190000E+01 Etot,Ep,Ek=   -0.9362093428E+03  ..... Fcheck= 0.104E+01
Iter=  0.200000E+01 Etot,Ep,Ek=   -0.9362093324E+03  ..... Fcheck= 0.921E+00
```

> etot.input.highprec

```
1           1
 IN.ATOM   = atom.config   
 JOB       = TDDFT
 convergence=difficult
 precision=double
 MD_DETAIL = 1, 20, 0.1, 300,300
 TDDFT_DETAIL = 1,30,30
 XCFUNCTIONAL = PBE
 IN.PSP1   = 31-Ga.LDA.fhi.UPF
 IN.PSP2   = 33-As.LDA.fhi.UPF
 Ecut      =   30.0
 num_band  =  30
 N123     = 32 32 32
```

> MDSTEPS.highprec

```
Iter=  0.100000E+00 Etot,Ep,Ek=   -0.9362093469E+03 .... Fcheck= 0.123E+00
Iter=  0.200000E+00 Etot,Ep,Ek=   -0.9362093463E+03 .... Fcheck= 0.977E+00
Iter=  0.300000E+00 Etot,Ep,Ek=   -0.9362093462E+03 .... Fcheck= 0.996E+00
Iter=  0.400000E+00 Etot,Ep,Ek=   -0.9362093459E+03 .... Fcheck= 0.993E+00
Iter=  0.500000E+00 Etot,Ep,Ek=   -0.9362093456E+03 .... Fcheck= 0.993E+00
Iter=  0.600000E+00 Etot,Ep,Ek=   -0.9362093456E+03 .... Fcheck= 0.100E+01
Iter=  0.700000E+00 Etot,Ep,Ek=   -0.9362093457E+03 .... Fcheck= 0.100E+01
Iter=  0.800000E+00 Etot,Ep,Ek=   -0.9362093456E+03 .... Fcheck= 0.998E+00
Iter=  0.900000E+00 Etot,Ep,Ek=   -0.9362093457E+03 .... Fcheck= 0.100E+01
Iter=  0.100000E+01 Etot,Ep,Ek=   -0.9362093454E+03 .... Fcheck= 0.996E+00
Iter=  0.110000E+01 Etot,Ep,Ek=   -0.9362093450E+03 .... Fcheck= 0.995E+00
Iter=  0.120000E+01 Etot,Ep,Ek=   -0.9362093446E+03 .... Fcheck= 0.995E+00
Iter=  0.130000E+01 Etot,Ep,Ek=   -0.9362093442E+03 .... Fcheck= 0.995E+00
Iter=  0.140000E+01 Etot,Ep,Ek=   -0.9362093440E+03 .... Fcheck= 0.998E+00
Iter=  0.150000E+01 Etot,Ep,Ek=   -0.9362093439E+03 .... Fcheck= 0.999E+00
Iter=  0.160000E+01 Etot,Ep,Ek=   -0.9362093438E+03 .... Fcheck= 0.999E+00
Iter=  0.170000E+01 Etot,Ep,Ek=   -0.9362093439E+03 .... Fcheck= 0.100E+01
Iter=  0.180000E+01 Etot,Ep,Ek=   -0.9362093438E+03 .... Fcheck= 0.999E+00
Iter=  0.190000E+01 Etot,Ep,Ek=   -0.9362093440E+03 .... Fcheck= 0.100E+01
Iter=  0.200000E+01 Etot,Ep,Ek=   -0.9362093440E+03 .... Fcheck= 0.100E+01
```

dt.
example:
etot.input.lowprec & small dt.

system size.
example:

integration accuracy.
example

# 15.get_vext

# 16.SOC

others sys_type, in.ferup-->in.occ,manual。
plot_tddft.f90加到util里。




