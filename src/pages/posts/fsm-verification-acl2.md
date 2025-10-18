---
layout: ../../layouts/BaseLayout.astro
title: "a sat-based procedure for verifying finite state machines in ACL2 - w. hunt et al."
date: "02.28.2025"
---
- sulfa properties converted into sat (cnf): 
- converting ACL2 conjectures into conjunctive normal form (CNF), which we then output and check with an external satisfiability solver. The procedure is directly available as an ACL2 proof request. When the SAT tool is successful, a theorem is added to the ACL2 system database as a lemma for use in future proof attempts. 
