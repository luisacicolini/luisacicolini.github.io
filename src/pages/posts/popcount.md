---
layout: ../../layouts/BaseLayout.astro
title: "population count"
---
*WIP*
# Popcount Circuits 

`popcount` is a common assembly primitive that counts the numbers of bits set to `1` in a bitvector. 
There are [various ways](https://nimrod.blog/posts/algorithms-behind-popcount/) to implement this, and 
I tried implementing them as circuits that Lean's bitblaster `bv_decide` can digest. The challenge for me 
were mainly 
1. writing the circuit in a functional language - which I'm still not used to 
2. the circuit must be tail-recursive
3. the proofs involved in their implementation require jiggling many diverse data structures and concepts.

### a note on `bv_decide`

`bv_decide` relies on constructing circuits for bitblasting: this construction itself relies on a lot of infrastructure and data structures. 
Understanding the entire process is a quest in itself - I still don't understand a big portion of it :(
Therefore, to approach the task, I am mostly looking through old PRs that added other circuits, 
I try to pattern-match behaviors that are similar to what I need and try to emulate them. 

The circuit we construct for `bv_decide` has an And-Inverted-Graph (AIG) structure, and in its construction
the main property we want to maintain is the *linearity* of the circuit. 
Basically, we want to make sure that we only *add* nodes to the circuit and never modify/update them, and 
that we have a *unique* aig as well. 
If we're careful enough, in the end, we'll have a circuit that is correct (!!) and that is al

### a note on tail recursion:
> Tail recursion is defined as a recursive function in which the recursive call is the last statement that is executed by the function. 
> So basically nothing is left to execute after the recursion call.

The main reason we want our functions to be tail-recursive has to do with stack optimization. 
With regular recursive functions, whenever we perform a new function call we also push a new stack frame on the stack, until the base case is reached.
```
        call n      call (n - 1)      call (n - 2)          ...             base case

stack:                                                      ...             sfr 0
stack:                                                      ...             ...
stack:                                                      ...             sfr (n - 4)
stack:                                                      ...             sfr (n - 3)
stack:                                sfr (n - 2)           ...             sfr (n - 2)
stack:              sfr (n - 1)       sfr (n - 1)           ...             sfr (n - 1)
stack:  sfr n       sfr n             sfr n                 ...             sfr n
```
Once the base case is reached, the program needs to traverse backwards the previous stack frames to eventually return the value. 

With tail-recursion, we avoid this backward-traversal of the stack: the last function call will already contain the output value we're looking for!
`sfr0` contains what we need already. A trick that is often used in `bv_decide` circuits, to ensure tail-recursion, it to have an accumulator as argument of 
the function: its value gets updated at every calls and corresponds to the state of the circuit. At the final call, it will contain the whole circuit :) 

From a pure compiler perspective, tail-recursive calls can be replaced by iterations (["contol flows to the end of the function body after each call"](https://digitallibrary.srisathyasaicollege.in/bitstream/123456789/6801/1/Alfred%20V.%20Aho%2C%20Monica%20S.%20Lam%2C%20Ravi%20Sethi%2C%20Jeffrey%20D.%20Ullman-Compilers%20-%20Principles%2C%20Techniques%2C%20and%20Tools-Pearson_Addison%20Wesley%20%282006%29.pdf)): this replacement imporves the compiled program's performance. 

To understand why this is useful, I found the following example particularly useful (from the [dragon book](https://digitallibrary.srisathyasaicollege.in/bitstream/123456789/6801/1/Alfred%20V.%20Aho%2C%20Monica%20S.%20Lam%2C%20Ravi%20Sethi%2C%20Jeffrey%20D.%20Ullman-Compilers%20-%20Principles%2C%20Techniques%2C%20and%20Tools-Pearson_Addison%20Wesley%20%282006%29.pdf)):
```
fun( ) {
    if lookahead = '+' then 
        consume('+')
        print(lookahead)
        consume(lookahead)
        print('+')
        fun ( )
    elif lookahead = '-' then 
        consume('-')
        print(lookahead)
        consume(lookahead)
        print('')
        fun ( )
}
```
that can be rewritten as
```
fun( ) {
    L:  if lookahead = '+' then 
            consume('+')
            print(lookahead)
            consume(lookahead)
            print('+')
            goto L 
        elif lookahead = '-' then 
            consume('-')
            print(lookahead)
            consume(lookahead)
            print('')
            goto L 
}
```


## [Brian Kernighan's algorithm](https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetKernighan): 
This algorithm basically subtracts `1` and `and`s the bitvector until it's `0`: 
```
    unsigned int v; // count the number of bits set in v
    unsigned int c; // c accumulates the total bits set in v
    for (c = 0; v; c++)
    {
    v &= v - 1; // clear the least significant bit set
    }
```
In the [circuit](https://github.com/leanprover/lean4/pull/9416/files), this translates to a series of `and` and `sub` nodes that needs to represent `x` at the right recursion level. 
A difficulty with this circuit is that for example, at iteration `c = i` the value of `v` will be the result of `i` `and` operations, and when we design the 
circuit tail-recursively, we need to keep that in mind and use another function `auxAnd` that computes the `and` of `v` and `v-1` exactly `i` times:
```
auxAnd (x, iter) {
    if 0 < iter 
        x &= x - 1
        auxAnd x (iter - 1)
    else 
        x
}

popCount (x, iter, acc) 
    if 0 < iter 
        xIter = auxAnd x iter 
        cond = xIter = 0
        newNode = ITE cond, iter, acc
        acc.pushNode newNode
        popCount x (iter - 1) acc
    else 
        acc
```
I benched this circuit within `bv_decide` and ultimately it is not as fast as I was expecting, and scales really bad. 
I found understanding why something is more or less digestible by a SAT solver particularly challenging.

## Intuitive popcount
An alternative circuit is the most ["naive"](https://github.com/leanprover/lean4/pull/9469) one we can come up with: 
for each bit in the input we generate an `if-then-else` node where the condition is "`bit = 0`". 
This circuit performs better than Kernighan's in this context, but still scales quite dramatically. 

## Divide-et-impera popcount
The final alternative is to use a divide-and-conquer strategy, which is what for example [Hackers' Delight](https://github.com/hcs0/Hackers-Delight/blob/master/pop.c.txt) proposes, namely the SWAR algorithm. The idea is to use bitmasks an shifts to `and` bits 
such that after `log2 w` operations (where `w` is the width of the input) eventually we'll have the final number. 

In the SAT solver, I [implemented](https://github.com/leanprover/lean4/pull/9730) a slightly more general circuit that allows me to avoid generating the magic constants. 
Eventually, my circuit is a [prefix sum](https://en.wikipedia.org/wiki/Prefix_sum) circuit: we zero-extend each 
bit in the input (of width `w`) to have width `w` and then add them in couples, until a single add node is left: 
```
input word      b0              b1              b2              b3               ...           b(w-1)
zero extend     b0.zExt w       b1.zExt w       b2.zExt w       b3.zExt w        ...           b(w-1).zExt w        
                        \        /                      \        /                         \        /
                         \      /                        \      /                           \      /
add 0                       +                               +              ...                  +              
                             \                             /                                   /
                              -----------------------------                     ---------------        
                                            |                                   |
add 1                                       +              ...                  +    
                                             \             ...                 /
...                                                     ...  ...
                                                           \ /
add log2 w                                                  +
```
The reason why we zero-extend each bit immediately to `w` is to have inputs with the same size on for all add nodes. 
The alternative to this would be extending by one bit at a time, which is very finnicky and eventually not 
particularly effective: 
```
input word      b0              b1              b2              b3               ...           b(w-1)
zero extend     b0.zExt 2       b1.zExt 2       b2.zExt 2       b3.zExt 2        ...           b(w-1).zExt 2        
                        \        /                      \        /                         \        /
                         \      /                        \      /                           \      /
add 0                     ( + ).zExt 4                    ( + ).zExt 4       ...              ( + ).zExt 4    
                             \                             /                                   /
                              -----------------------------                     ---------------        
                                            |                                   |
add 1                                       ( + ).zExt 8   ...                ( + ).zExt 8
                                             \             ...                 /
...                                                     ...  ...
                                                           \ /
add log2 w                                                ( + ).zExt w
```
Note that we really need this extention, otherwise we won't be able to count correctly, for example, in the first
set of add nodes: 
```
b0=1       b1=1 
    \     /
       +
       |
       10
```
without the zero-extension we'd have overflow :(. 

```
first time i call blastAddVec from go
oldParSum:  .     .     .     .     .     .     .     .     validNodes = 8, usedNodes = 0
newParSum:  .     x     x     x     x     x     x     x

oldParSum:  .     .     .     .     .     .     .     .     validNodes = 8, usedNodes = 2
newParSum:  .     .     x     x     x     x     x     x

..

newParSum:  .     .     .     .     x     x     x     x     validNodes = 8, usedNodes = 8

2nd time i call blastAddVec from go
oldParSum:  .     .     .     .     x     x     x     x     validNodes = 4, usedNodes = 0
newParSum:  .     .     x     x     x     x     x     x

3rd time i call blastAddVec from go
  .     .     x     x     x     x     x     x
  .     x     x     x     x     x     x     x

4th call (hypothetical): validNodes = 1 → return
```