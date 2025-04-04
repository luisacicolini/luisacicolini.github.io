(include-book "centaur/sv/top" :dir :system)
(include-book "centaur/vl/loader/top" :dir :system)
(include-book "centaur/vl/top-doc" :dir :system)
(include-book "quicklisp/top" :dir :system)
(include-book "oslib/top" :dir :system)


1. load the file in *otbn-vl-design*

(defconsts
  (*otbn-vl-design* state)
  (b*
    (((mv loadresult state)
      (vl::vl-load (vl::make-vl-loadconfig :start-files (list "../simple-design.sv")))))
    (mv (vl::vl-loadresult->design loadresult)
        state)))
        
2. check that no parsing errors occurred

(cw-unformatted (vl::vl-reportcard-to-string
                     (vl::vl-design-reportcard *otbn-vl-design*)))

3. convert the aes_ctr_fsm module into a FSM

(defconsts
     (*otbn-svex-design* *otbn-simplified-good*
                        *otbn-simplified-bad*)
     (b* (((mv errmsg svex-design good bad)
           (vl::vl-design->sv-design "aes_ctr_fsm" *otbn-vl-design*
                                     (vl::make-vl-simpconfig))))
       (and errmsg (raise "~@0~%" errmsg))
       (mv svex-design good bad)))

4. check the output of the conversion 

(cw-unformatted
 (vl::vl-pps-modulelist (vl::vl-design->mods *otbn-simplified-bad*)))

(cw-unformatted
 (vl::vl-pps-modulelist (vl::vl-design->mods *otbn-simplified-good*)))

5. print the whole svex design 

(without-evisc *otbn-svex-design*)

use (set-iprint t) to enable debug mode!

6. create channel for output redirection 

(mv-let (chan state)
        (open-output-channel "simple-design.out" :character state)
        (set-proofs-co chan state))

7. redirect stdout to that channel

(set-standard-co (proofs-co state) state)

8. compile design to fsm

(sv::svex-design-compile *otbn-svex-design*)

