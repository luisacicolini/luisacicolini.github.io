---
layout: ../../layouts/BaseLayout.astro
title: "population count"
---
# Popcount Circuits 

`popcount` is a common assembly primitive that counts the numbers of bits set to `1` in a bitvector. 
There are [various ways](https://nimrod.blog/posts/algorithms-behind-popcount/) to implement this, and 
I tried implementing them as circuits that Lean's bitblaster `bv_decide` can digest. The challenge for me 
were mainly 
(1) writing the circuit in a functional language - which I'm still not used to 
(2) the circuit must be tail-recursive

### a note on bv_decide

### a note on tail recursion:
> Tail recursion is defined as a recursive function in which the recursive call is the last statement that is executed by the function. 
> So basically nothing is left to execute after the recursion call.
The main reason we want our functions to be tail-recursive has to do with stack optimization. 
With regular recursive functions, whenever we perform a new function call we also push a new stack frame on the stack, until the base case is reached.
```
        call n      call (n - 1)      call (n - 2)          ...             base case

stack:                                                      ...             sfr 0
stack:                                                      ...             ...
stack:                                                      ...             sfr n
stack:                                                      ...             sfr n
stack:                                sfr n                 ...             sfr n
stack:              sfr n             sfr n                 ...             sfr n
stack:  sfr n       sfr n             sfr n                 ...             sfr n
```
Once the base case is reached, the program needs to traverse backwards the previous stack frames to eventually return the value. 

With tail-recursion, we avoid this backward-traversal of the stack: the last function call will already contain the output value we're looking for!
`sfr0` contains what we need already. 

From a pure compiler perspective, tail-recursive calls can be replaced by iterations (["contol flows to the end of the function body after each call"](https://digitallibrary.srisathyasaicollege.in/bitstream/123456789/6801/1/Alfred%20V.%20Aho%2C%20Monica%20S.%20Lam%2C%20Ravi%20Sethi%2C%20Jeffrey%20D.%20Ullman-Compilers%20-%20Principles%2C%20Techniques%2C%20and%20Tools-Pearson_Addison%20Wesley%20%282006%29.pdf)): this replacement imporves the compiled program's performance. 


1. Brian Kernighan's algorithm