---
layout: ../../layouts/BaseLayout.astro
title: "OOPSLA'25"
date: "11.15.2025"
---
# OOPSLA'25
Attending ICFP and OOPSLA 2025 was definitely *an experience*. 
There's so much to learn out there and it can be overwhelming - makes me feel like there's really 
not enough time to learn all the things I would like to learn ☹️

[Satnam Singh](https://raintown.org/) kicked of ICFP with a keynote on functional languages for 
hardware verification, which was incredibly interesting 
(especially after all the previous conversations at [HASE](https://luisacicolini.github.io/posts/hase-25/)). 
Verilog, VHDL, architectures seem to me so far from the questions type theory seems to be interested in, 
but they are in fact pretty close. Or at least have some shared interests. 
The modular way of thinking functional programming imposes is similar to what computer architects and 
designers do, especially when we want to model a component thinking about what it outputs depending on which inputs. 
(yes, I continue to not understand monads, yes I'm still in the a process lol)

ICFP works give interpretations of the world in terms of *more-or-less-abstract nonsense* that are very fascinating. 
Seeing how much *abstract nonsense* exists and can be used to model things that we use every day gave 
me insight on how much the perspective we have on a problem shapes the kind of solution we find. 
And how much a different perspective can enable the "discovery" process. 
It's the way we talk and think about *things* that gives shape to what we can do with the *things*. 

On this note, chatting with Satnam made me realize how much *abstract nonsense* and hardware verification need each other - 
despite being so different!
There's a lot of cool maths out there that can help us making hardware verification better, 
and it's important to bridge these two sides of the spectrum (yes, monads too). 
**Coinduction** is my favorite example: we can talk about it in categorical and abstract terms and at the same time 
we can use it to model sequential logics in circuits and even more complex hardware such as dataflow. 

### women in pl dinner

I honestly used to be skeptical about this kind of events but ended up enjoy this particular one so much!
It sounds super cliche to say that *I got to chat with inspiring women and role-models* but that was so true. 
I spent some time discussing some recent questions I am trying to answer about modelling latency-insensitive 
designs - and received a lot of pointers to tools, papers, theories that I never thought would fit (but they seem to). 
Even regexes, my *first academic love*, unsuspectedly came back in a totally new shape and with a totally 
new role. 
Special thanks to [Yahui](https://songyahui.github.io/) for the inspiring regex and ltl conversations!
It was so motivating to see these amazing women and talk about maths and computer science, I got 
inspiration for works I thought were stuck ... and made friends. 

### more or less random collection of papers/topics/things
- the works by [mary sheeran](https://www.cse.chalmers.se/~ms/)
- [Lava: hardware design in Haskell](https://dl.acm.org/doi/abs/10.1145/291251.289440), a pioneering work 
- the concept of [benes network](https://homepages.inf.ed.ac.uk/rni/comp-arch/Networks/benes.html)
- [rewriting extended regular expressions](https://www.sciencedirect.com/science/article/pii/0304397595800244) to verify the infinite streams we have at latency-insensitive levels of abstraction in hardware.
- [hylo](https://hylo-lang.org/) 
- [waterfall](https://www.cs.utexas.edu/~moore/acl2/v8-5/combined-manual/index.html?topic=ACL2____HINTS-AND-THE-WATERFALL) in acl2 - thanks to my new-acl2-friend!
- [type universes as kripke worlds](https://dl.acm.org/doi/abs/10.1145/3747532): I loved studying Kripke frames and worlds - this work uses them to model very concrete semantics. 
    It was nice to bump into Kripke again :)
- theory of bitvector interpolation: a lot of cool bitvector maths (and open questions), for example [here](https://link.springer.com/content/pdf/10.1007/s10703-021-00372-6.pdf) and [here](https://link.springer.com/content/pdf/10.1007/978-3-030-45190-5_5.pdf)
- [interpolation in z3](https://www.cs.utexas.edu/~hunt/FMCAD/fmcad11/papers/81.pdf)
- [non-linear invariants generation](https://dl.acm.org/doi/10.1145/964001.964028)
- [an introduction to bisimulation and coinduction](https://www.cs.unibo.it/~sangio/DOC_public/corsoFL.pdf)
- [hazel](https://neurocy.notion.site/Hazel-Crash-Course-659f6b5807864d68a7fb723ff467811c) and [hazelnut](https://arxiv.org/pdf/1607.04180)
- the marvelous semantics of [machine knitting](https://uwplse.org/2025/03/31/Algebraic-Knitting.html)
- [a coinductive calculus of streams](https://research.vu.nl/ws/portalfiles/portal/2409636/219599.pdf)
- [foundations of digital circuits](https://arxiv.org/abs/2502.08497)