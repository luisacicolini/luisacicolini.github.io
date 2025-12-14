---
title: "ItaLean'25"
date: 2025-12-14
---


# ItaLean'25

🇮🇹 I spent the last week in Bologna, attending [ItaLean](https://pitmonticone.github.io/ItaLean2025/). 
The organizers did an amazing work and pulled together an exceptional board of speakers and panelists, 
it was great (and a great reason for pride!) to see something like this happen *in Italy*. 
Hopefully we'll see more events like this one :) 

Open source communities are typically kind and welcoming - contributors tend to be *excited* about what they do and happy to share and explain it: 
this aspect contributed to making the conference very productive (at least for me, I learned soooo much). 

### Lean4
[Leonardo de Moura](https://leodemoura.github.io/) kicked off the conference with the history of Lean (most of which I did not know). 
For example, the reason why we don't have [homotopy type theory](https://en.wikipedia.org/wiki/Homotopy_type_theory) in Lean is that in HoTT *proofs are not necessarily irrelevant*, 
and supporting this in the kernel is very complex. Support for HoTT was removed starting from Lean3, and in Lean4 *proof irrelevance* holds.
Lean4's popularity is partially to the *famous, enthusiastic mathematicians* that started using it to formalize their research and to teach maths: 
eminent researchers and professors from the maths community adopted it more and more, contributing to its fame, shaping its development and 
the community around it. 
Lesson: to have an impact it's important to choose carefully the projects you invest your energies in.

### what's a *good definition*?
In the mixed computer science/maths community it's interesting to see how people go at the same thing: 
and in particular how they go at finding *a good definition* (something I care about quite a lot lately). 
Some questions to ask when we want to come up with a good a definition: 
*What's a good definition in maths? 
Is that the same as a computer-sciencey good definition? 
Why do we care about a definition being at the right level of generality and abstraction? 
What's the right level of generality and abstraction? Is the definition ergonomic?
Is that definition readable or do we have to carry around too many parameters?
What are the pre requisites to using and understanding that definition?
Is there a metric beyong beauty™️ to call a mathematical definition good?*
From what I've seen in the past days, it seems like math people seem to focus more on *usability*, 
while computer scientists care a lot about the maintainability, performance and *good development practices*. 

### how does one design a *good library*?
It was also very useful to see how people design and use libraries (also something I care about lately), 
how they reason about it and how they motivate their choices. 
Questions to think about when designing a library:
*What's the intended use of X? And again is that at the right generality level?
Will people that do Y find that useful or will they need a similar-but-slightly-different flavor of the same thing? 
How do we make it maintainable and comfortable for as many users as possible?*
It seems like a lot of these answers are found by gathering people that are **passionate**, 
**not afraid** to ask questions and **argue** their positions, 
**non-content** with an obvious answer, 
obsessed with understanding things in **detail**, 
obsessed with the **quality** of what they do and with pushing it to its best. 
Being around these people and working with them is a privilege. 

### learning maths
🥔 I learned about manifolds!
[Michael Rothgang](https://www.math.uni-bonn.de/people/rothgang/) introduced them in a very intuitive way: 
I really enjoyed the introductory-maths-talks, as they gave me an insights into areas of maths that I could never look into by myself.
The conference was very much maths oriented, but the fact that it was [`mathlib`](https://github.com/leanprover-community/mathlib4) 
maths made it more approachable for computer scientists as well. 
I have not yet tried to properly learn maths from `mathlib`, but I have a feeling it would be easier than books, 
because it is structured in libraries and because everything has its own type. 
This probably makes it easier to reason about the dependencies and similarities between different definitions 
(e.g. two definitions with an attribute of of the same type). We'll see if and when I actually try 😬. 

### project work
Kudos to the organizers for the project work: it was great.
I worked on the `grind` and `aesop` tactic annotations for both mathlib and lean and enjoyed it a lot. 
Being taught how the tactics work by their own authors, seeing how their reasoning and intuition works is a very effective way to learn (who would have guessed 😬). 
It feels like a of *proof engineering* is based on intuition, which one develops with experience and with seeing the same concepts behaving differently in different proofs, 
and building intuition takes a lot of *time and effort*. 
The learning curve is especially steep, and it takes quite some time to see the results.  
I'm very grateful for the time these people put into answering my questions and helping me understand - 
again a perk and a privilege of the lean community: people are kind and people are happy to help, explain, share. 


### AI
I am scared of AI: scared it will take my job, scared to feel aimless if it can replace me and therefore be *sad*, scared with how society will change.
*What if AI becomes a better professor and researcher than I could ever be?*
To deal with fear I think it's important to learn: learn about AI, talk to people that develop and use it, talk to people whose jobs are already being impacted by it. 
Having so many AI experts in the room and talking about their experience was very helpful with that. 
Takeaways: 
- AIs can help us and make us *smarter*, if we take the time to learn how to make the most of them
- The *human* aspect of teaching makes it rewarding 
- How do we incentivize students to learn *for real for real* and not just find and memorize the answers AI can give? 


### misc of papers/topics/thingss

- [the cathedral and the bazaar](https://en.wikipedia.org/wiki/The_Cathedral_and_the_Bazaar)
- [loom](https://verse-lab.org/papers/loom-popl26.pdf), [veil](https://link.springer.com/chapter/10.1007/978-3-031-98682-6_2), [velvet](https://verse-lab.org/papers/velvet-dafny26.pdf)
- [term ordering diagrams](https://arxiv.org/abs/2505.22181)
- [language server protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol)