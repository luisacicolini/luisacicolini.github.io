---
layout: ../../layouts/BaseLayout.astro
title: "HASE'25"
date: "10.24.2025"
---

# HASE'25

This October, I had the chance to fly out to Taipei for the [HASE](https://hase-workshop.org/) conference, for its comeback after the previous [2020 edition](https://conf.researchr.org/series/hase). 
It's been an inspiring event and I learned a lot of things, some of which are worth writing down (and hopefully looking back to in a few months or years from now). 

It was immediately clear that HASE has a very different organisation from other conferences: no pre-organised talks, a relatively small number of attendees, and an overall setup that really favours 1:1 interaction *with everyone*, focusing on problems/challenges/solutions in any area concerned with building high assurance systems. 
This means that attendees can have very different backgrounds and objectives: formal verification in all its theoretical/mathematical/practical flavors and with different languages, hardware architects and designers working at various levels of abstraction, cryptography and security experts, industry people, academia people...

A crowd so rich and diverse that it's impossible to *not learn anything*. 

Most of the event consisted of relatively short sessions, where participants can share their skills in a domain they know well, presenting the challenges, available solutions, cool and uncool things existing in that domain.  
This set up makes it easy to ask a lot of questions and get very specific and clear answers: **it's easier to say *"I don't understand"* in a small crowd than in a giant conference room** (at least for me), 
and in a small group every question can become an actual *conversation*, where everyone contributes!
It's really, really, really hard to *not learn anything*. 
What follows is a list of some things I've learned during various sessions and conversations. 


### trusting hardware

I always read (and write 😅) in papers that *verification is the bottleneck of hardware design* and that *mistakes in hardware design are critical and expensive*: 
at HASE I had the chance to go to the bottom of these statements and learn about the hardware bugs that can arise at the end of the design stack, e.g. during the wiring or printing of a board. 

A brief summary of how hardware design happens:
- specification 
- RTL + verification (iterating as much as needed!)
- Synthesis
- Place & route 
- Mask making 
- FEOL 
- BEOL 
- Test + pack + product

A problem hardware people seem to have has to do with malicious behaviours on devices/boards that look okay at first sight.
For example, attacks that add an *extra layer* on certain components of the board, changing its behaviour without changing its aspect. 

The question then becomes: how can we test for these attacks? And how do we do it in a way that *scales*? 

A way of testing for these attacks consists of adding some dummy components that would make tamperings *too* evident and visible:
for example, ensuring that the minimal attack surface requires enough transistor/physical changes to be noticeable. 
Sadly, though, compilers in EDA toolchains tend to *optimize* these dummy components away, given that they're not needed, causing the failure of these mitigation attempts. 
This is instance of the wider clash of *Power, Performance, Area vs. Security* (spoiler: we typically optimize for and prioritize the first). 
I found it very interesting (and unexpected, and also funny) how this community seems to want compilers that are *less smart* and *less optimizing* 🥶.
I would have never guessed anything like that could exist!

The community also seems to be interested in *interactive compilers*, that allow taking a closer look at the applied passes, customizing what (not) to delete and optimize. 

### information flow security 

I had very little sense of the challenges people in this area are interested in before attending this session, which made it a super fruitful one 🍎.
I learned that describing information flow at the interface between software and hardware is incredibly hard: the properties/guarantees people are interested in differ at each domain and every community seems to mostly focus on what happens in its own garden ☹️.
    
A few other problems posed by the verification of information flow are: 
- Describing and verifying what happens when multiple components *interact*: this is common to many areas that use formal verification (interaction between hardware components, interaction between abstractions, interaction between elements in an abstraction... there are so many)
- Modelling non-determinism or enforcing scheduling? Another dilemma that also arises in the verification of hardware and its latency-insensitive abstractions.  
- What's a reasonable/reproducible/realistic threat model?
- What's a good way to formally define information flow? What vulnerabilities do we want the definition to capture? Do we focus on functional correctness?
- How do we talk about the difference between information flow at the software and hardware levels? Hardware info flow can have leakages that don't appear at the software level: what's wrong with these interfaces? And what happens, e.g., at the super low *gate* level? Do we even need to think about that? 
- How do we deal with the limits of semantics-based approaches against physical attacks?

### hardware semantics 

Throughout the two days, we had various different conversations about the mathematical and logical models we use to represent hardware abstractions, and in particular, *why* some things work better than others. 
A shared and agreed-upon fact is that *functional languages* are particularly suitable for said models, and a key reason is that they make compositionality easier.
With functional languages, we can represent the interaction between two modules as the composition of two functions describing a module each. 
This is an interesting insight for the work I've been recently carrying out with [lean-mlir](www.github.com/opencompl/lean-mlir) regarding the mechanization of [CIRCT](www.circt.llvm.org) dialects. 
It took me a while of thinking and meditating about this to be fully convinced, especially because functional languages are not yet an intuitive mental model for me, but I am getting there. 
Another interesting point is that functional languages make it easier to reason algebraically about what we describe. 
Monads also play a useful role in this, and are a great abstraction (or maybe *framework* is a better term?) to reason about the semantics we want to model and the way they interact, e.g., in a design. 
This was also the topic of Satnam Singh's very interesting keynote at ICFP'25. 
I am still unsure why we care so much about monads, but reasoning about it in terms of "just an abstraction" (thank you, [Joachim](https://github.com/nomeata), for the mental model!) is helping. 


### open problems with bitvectors

*Bitvectors are temperamental.*

A bitvector (vector of bits - 1s and 0s) can be interpreted as a natural number, integer number... or just as a set of logical bits: 
1. natural: `101` = $1 * 2 ^ 0 + 0 * 2 ^ 1 + 1 * 2 ^ 2 = 5$
2. integer: `101` = $1 * 2 ^ 0 + 0 * 2 ^ 1 + 1 * 2 ^ 2 - 2 ^ 8 = -2$ (see [cp2](https://en.wikipedia.org/wiki/Two%27s_complement))
3. bits: `101`

Depending on what we're doing, we might want to decide properties about bitvectors that treat them as natural/integers or as boolean formulae (e.g. `101 && 110 = 100`). 
This makes deciding such properties complex, especially when we want to tackle both the arithmetic and the logical behaviour. 
SMT has its own [theory](https://smt-lib.org/theories-FixedSizeBitVectors.shtml) to talk about bitvectors, considering all these behaviours. 
Integrating both approaches in a solver requires a lot of work, and we seem to still struggle with this (more work for me 😇). 

### some inspiring papers/topics/problems: 
- [orthologic](https://arxiv.org/abs/2501.09418): speeding up decision procedures by limiting the decided fragment in a smart way 
- [the post-correspondence problem](https://en.wikipedia.org/wiki/Post_correspondence_problem)
- [a solver for arrays with concatenation](https://dl.acm.org/doi/abs/10.1007/s10817-022-09654-y)
- [LEGO proof assistant](https://www.dcs.ed.ac.uk/home/lego/)
- [algebraic methods for optimization problems](https://www.cs.ox.ac.uk/people/jeremy.gibbons/publications/acmmpc-optimization.pdf) and richard bird's work in general 
- [interaction trees](https://dl.acm.org/doi/10.1145/3371119) 
- [egglog](https://github.com/egraphs-good/egglog) 
- [arvind](https://scholar.google.com/citations?user=_BqpjCgAAAAJ&hl=en&oi=ao)'s works 