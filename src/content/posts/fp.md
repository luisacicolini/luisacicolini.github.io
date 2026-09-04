---
title: "[WIP] FP madness"
date: 2026-06-13
---

### FP madness


- guard and sticky: if both are zero no rounding is necessary 
- we care about the sign of zero because of +- infinite in division by zero + preservind identity (x ^ (-1)) ^ (-1) = x 
- what's the lower/higher of zero?
- problem: mapping the real number zero to +0/-0 -> the lower of zero is the largest fp number whose val is <= 0, which is +0. 

fact: lower(0 : Real) = +0, higher(0 : Real) = -0. counterintuitive. 
reason: lower = "give me the greatest lower bound", which is +0, because the ordering on the floating point are designed s.t. 
a neg number is always smaller than pos number, if two numbers are positive then the number w the smaller exp is smaller 
than the number with the larger exp etc etc. 

partial order for fp8 vs partial order for reals: 

for every fp8 val, we can compute the corresponding real. this function is always 1:1 except for the point "0", 
where it is 2:1, because both +0 and -0 have (real) value 0. 

on the way back from real to fp8, we have 2 ways to go back: 
1. lower: GLB (greatest lower bound): see all the fp numbers that map to a value <= to our real value, pick the largest one.
2. higher: LUB (least upper bound): see all the fp numbers whose value is <= real number, then pick the smallest fp value. 

another corner case: 
suppose we have a number that's fpmax, i.e., the largest representable number. 
we also have +inf in fp, so a real number larger than the max val but less than inf, then lower = fpmax, higher = inf 

weird rounding mode; round to nearest even. if we are strictly in the middle, some rounding modes say "pick higher", 
RNE says "pick the number whose lsb is 0". funny implication: in the "> fpmax" case, what do we return? 
the max value can't be even bc the largest number will have all ones in the significant. 
so fpmax is odd, we cant round to it with RNE, so we round to infinity. so in fp infinity is an even number. 