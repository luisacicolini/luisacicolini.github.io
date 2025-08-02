---
layout: ../../layouts/BaseLayout.astro
title: "acl2"
---
# FSM extraction with ACL2

ACL2 is a very nice proof assistant, that contains a bunch of libraries (`books`), each of which contains theorems useful for formal verification.
In particular, they have a tool to verify SystemVerilog designs by extracting a FSM from the design (the FSM format is called `svex`) such that it can be fed to a SAT solver (Hunt 2006).

ACL2 works very well with emacs (which is initially a pain in the neck, but is actually worth it!)

The TLDR to use ACL2 for hardware verification is quite straightforward: there are no variables, we call one by one the functions we want to apply and store them in *constants*, which
we can then use as arguments for other functions. I like to think about it incrementally: once you call a function, its result will continue existing in your scope and is immutable.

A short guide to extract a FSM from a SystemVerilog design:

1. load the books containing the functions we'll need:
```
    (include-book "centaur/sv/top" :dir :system)
    (include-book "centaur/vl/loader/top" :dir :system)
    (include-book "centaur/vl/top-doc" :dir :system)
    (include-book "quicklisp/top" :dir :system)
    (include-book "oslib/top" :dir :system)
```
2. load the SystemVerilog file in *vl-design*
```
    (defconsts
    (*vl-design* state)
    (b*
        (((mv loadresult state)
        (vl::vl-load (vl::make-vl-loadconfig :start-files (list "../simple-design.sv")))))
        (mv (vl::vl-loadresult->design loadresult)
            state)))
```
3. check that no parsing errors occurred
```
    (cw-unformatted (vl::vl-reportcard-to-string
                     (vl::vl-design-reportcard *vl-design*)))
```
4. convert the loaded module into a FSM
```
    (defconsts
        (*osvex-design* *simplified-good*
                            *simplified-bad*)
        (b* (((mv errmsg svex-design good bad)
            (vl::vl-design->sv-design "aes_ctr_fsm" *vl-design*
                                        (vl::make-vl-simpconfig))))
        (and errmsg (raise "~@0~%" errmsg))
        (mv svex-design good bad)))
```
5. check the output of the conversion
```
    (cw-unformatted
    (vl::vl-pps-modulelist (vl::vl-design->mods *simplified-bad*)))
    (cw-unformatted
    (vl::vl-pps-modulelist (vl::vl-design->mods *simplified-good*)))
```
6. print the whole svex design
```
    (without-evisc *svex-design*)
```
7. create channel for output redirection
```
    (mv-let (chan state)
            (open-output-channel "simple-design.out" :character state)
            (set-proofs-co chan state))
```
8. redirect stdout to that channel
```
    (set-standard-co (proofs-co state) state)
```
9. compile design to fsm
```
    (sv::svex-design-compile *svex-design*)
```
-> use `(set-iprint t)` to enable debug mode!

Emacs has a lot of commands, knowing them is quite useful.
