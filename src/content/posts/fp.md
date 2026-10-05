---
title: "FP madness"
date: 2026-06-13
---

# FP madness

### Guard and sticky bits 

[defs:](https://pavpanchekha.com/blog/rounding-bit.html)
> The "guard bit" tells you if the next bit (which would be rounded off) is a one or a zero.

> The "sticky bit" tells you if any further bits are ones

If both guard and sticky are zero no rounding is necessary :)

### Sign of zero

- We care about the sign of zero because +/- infinite in division by zero yields *different* infs
- We want to preserve identity: $(x ^ {-1}) ^{-1} = x$
- When rounding, we want to know what's the `lower`/`higher` of zero

Recall that `higher` finds the smallest representable floating-point number that is greater than a given value, 
and `lower` finds the largest representable floating-point number that is less than a given value.
**What happens when we map the *real* zero to FP?**

We get that -- by definition -- the `lower` of zero is the **largest** FP number whose val is $val \le 0$, which is $+0$. 

**Counterintuitive fact:** 
- `lower(0 : Real) = +0` 
- `higher(0 : Real) = -0`. 

This is because `lower` gives us the greatest lower bound, which is $+0$, because the ordering on the floating point are designed such that **a negative number is always smaller than a positive one**. 
Then, if two numbers are positive, the number with the smaller exponent is smaller 
than the number with the larger exponent, etc etc...

### Example: Partial order for FP8 vs partial order for Reals 

For every FP8 value, we can compute the corresponding real. 
This function is always a 1:1 mapping, except for the point `0`, 
where it is 2:1, because both `+0` and `-0` have (real) value `0`. 

So, on the way back from real to FP8, we have two options: 
1. `lower`: GLB (greatest lower bound): observe all the FP numbers that map to a value $\le$ to our real value, pick the largest one.
2. `higher`: LUB (least upper bound): see all the FP numbers whose value is $\le$ real number, then pick the smallest fp value. 

### FPMax

Suppose we have a number that's FPMax, i.e., the largest representable number. 
In FP, we also have positive and negative infinites, 
so for a *real* number `n` larger than the max value but smaller than infinite we have: 
- `lower(n) = fpmax`
- `higher(n) = inf` 

### Weird rounding mode: RNE

This is a weirder rounding mode *round to nearest even*:
RNE says "pick the number whose LSB is 0". 

As a funny implication: in the *greater than FPMax* case, what do we return? 
The max value **can't** be even because the largest number will have *all ones* in the significant: 
so FPMax is odd, and we can **not** use it for rounding with RNE, so we round to infinity. 

In FP, infinity is an even number :)