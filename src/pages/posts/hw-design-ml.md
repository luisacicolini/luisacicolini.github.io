---
layout: ../../layouts/BaseLayout.astro
title: "hw design with/for ml - lizy john"
date: "05.24.2024"
---
# hw design with/for ml
- Exploit SW optimization first
- Add hard matrix multiplier blocks to FPGA → how many? trade off: small area 3-5% (“Tensor Slices”) doubles the throughput for ML applications, w\out increasing the overall area, no extra general purpose connection required, no slowdown in non-ML benchmarks
- Add compute in RAMs: improvement with +3% extra hw → reduction in data movement
- Weightless NN have potential
- ML for performance modeling: (1) calibration of power models using ML → McPAT, simulator to model machines that do not exist yet
- Interest in ML-guided HW design → Computer Architecture 2.0, e.g. ML-based branch predictors?
