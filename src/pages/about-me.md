---
layout: ../layouts/BaseLayout.astro
title: "timeline"
---

<script is:inline>
  document.addEventListener('DOMContentLoaded', () => {
    const timeline = document.querySelector('.timeline');
    const toggleButton = document.querySelector('#timeline-toggle');
    const allItems = timeline.querySelectorAll('li');
    const hiddenItems = Array.from(allItems).slice(15); 
    
    const initializeView = () => {
        if (hiddenItems.length > 0) {
            hiddenItems.forEach(item => {
                item.style.display = 'none';
            });
            toggleButton.textContent = `show more`;
            toggleButton.style.display = 'block'; 
        } else {
            toggleButton.style.display = 'none';
        }
    }

    const toggleView = () => {
      const isHidden = hiddenItems[0].style.display === 'none';
      
      if (isHidden) {
        hiddenItems.forEach(item => {
          item.style.display = 'grid'; 
        });
        toggleButton.textContent = 'Hide';
      } else {
        hiddenItems.forEach(item => {
          item.style.display = 'none';
        });
        toggleButton.textContent = `show more`;
      }
    };

    if (toggleButton) {
      toggleButton.addEventListener('click', toggleView);
    }
    
    initializeView();
  });
</script>

## a bit of what i've been up to lately: 

<ul class="timeline">
  <li>
    <span class="date">dec. 25</span>
    <span class="activity">i'm attending <a href="https://pitmonticone.github.io/ItaLean2025/">ItaLean'25</a> in Bologna</span>
  </li>
  <li>
    <span class="date">oct. 25</span>
    <span class="activity">i'm attending & student-volunteering at OOPSLA'25 in Singapore</span>
  </li>
  <li>
    <span class="date">oct. 25</span>
    <span class="activity">i'm attending HASE'25 in Taipei</span>
  </li>
  <li>
    <span class="date">oct. 25</span>
    <span class="activity">started PhD!</span>
  </li>
  <li>
    <span class="date">jun. 25</span>
    <span class="activity">i'm attending <a href="https://www.newton.ac.uk/event/bprw03/">Big Proof'25</a></span>
  </li>
  <li>
    <span class="date">mar. 25</span>
    <span class="activity">i'm the <a href="https://2026.cgo.org/committee/cgo-2026-organizing-committee">publicity chair</a> for CGO'26</span>
  </li>
  <li>
    <span class="date">dec. 24</span>
    <span class="activity">i'm an artifact evaluator for <a href="https://2025.cgo.org/">CGO'25</a></span>
  </li>
  <li>
    <span class="date">oct. 24</span>
    <span class="activity">again in California, this time presenting a technical talk <a href="https://www.youtube.com/watch?v=ga0VHhwmKMM&amp;t=682s">"Exploiting MLIR Abstractions for Hardware Verification"</a> at LLVM-dev! my first time at an LLVM-dev meeting, and I met so many inspiring people :)</span>
  </li>
  <li>
    <span class="date">mar. 24</span>
    <span class="activity">i'm the <a href="https://2025.cgo.org/committee/cgo-2025-organizing-committee">publicity chair</a> for CGO'25</span>
  </li>
  <li>
    <span class="date">mar. 24</span>
    <span class="activity">in Copenhagen to be a student volunteer at PLDI'24 - my first time at a more "theoretical" conference: made me realize how much more I need to study and learn to shift towards more theoretical research!</span>
  </li>
  <li>
    <span class="date">mar. 24</span>
    <span class="activity">started my job as a research assistant at the University of Cambridge</span>
  </li>
  <li>
    <span class="date">mar. 24</span>
    <span class="activity">briefly back in Edinburgh to be a student volunteer at CGO'24</span>
  </li>
  <li>
    <span class="date">feb. 24</span>
    <span class="activity">got my Abilitazione Professionale - Ingegnere dell'Informazione</span>
  </li>
  <li>
    <span class="date">jan. 24</span>
    <span class="activity">i'm the <a href="https://conf.researchr.org/committee/cgo-2024/cgo-2024-organizing-committee">publicity chair</a> for CGO'24</span>
  </li>
  <li>
    <span class="date">dec. 23</span>
    <span class="activity">the whole research lab moved to Cambridge! I'm now a visiting research student at the University of Cambridge.</span>
  </li>
  <li>
    <span class="date">oct. 23</span>
    <span class="activity">got my MSc in Computer Science Engineering from Politecnico di Milano</span>
  </li>
  <li>
    <span class="date">oct. 23</span>
    <span class="activity">our paper <a href="https://scholar.google.com/citations?view_op=view_citation&amp;hl=en&amp;user=q1-QIqUAAAAJ&amp;citation_for_view=q1-QIqUAAAAJ:u-x6o8ySG0sC">"One Automaton to Rule Them All: Beyond Multiple Regular Expressions Execution"</a> is accepted at CGO'24 :)</span>
  </li>
  <li>
    <span class="date">oct. 23</span>
    <span class="activity">TA-ing <code>Theoretical Computer Science</code></span>
  </li>
  <li>
    <span class="date">sep. 23</span>
    <span class="activity">moved to Edinburgh to join prof. <a href="https://grosser.science/">Tobias Grosser's group</a> as a visiting research student</span>
  </li>
  <li>
    <span class="date">sep. 22</span>
    <span class="activity">our paper <a href="https://ieeexplore.ieee.org/iel7/9937201/9937203/09937706.pdf">"Surfing the wavefront of genome alignment"</a> is accepted at ISCAS 2022 :)</span>
  </li>
  <li>
    <span class="date">jul. 22</span>
    <span class="activity">became chair of <a href="https://www.ieee.org/membership/women/">WIE</a> in the Politecnico di Milano IEEE Student Branch</span>
  </li>
  <li>
    <span class="date">mar. 22</span>
    <span class="activity">student volunteer at DATE'22 conference (online)</span>
  </li>
  <li>
    <span class="date">jan. 22</span>
    <span class="activity">tutoring <code>Algoritmi e Principi dell'Informatica</code> project course for computer science engineers</span>
  </li>
  <li>
    <span class="date">sep. 21</span>
    <span class="activity">in Rome presenting <a href="https://www.deib.polimi.it/eng/news/details/1004"><code>CareLivers</code></a>, our finalist project at Alfathon, hosted by Alfasigma</span>
  </li>
  <li>
    <span class="date">sep. 21</span>
    <span class="activity">tutoring <code>Informatica A</code> course for mathematical engineers</span>
  </li>
  <li>
    <span class="date">sep. 20</span>
    <span class="activity">joined the Politecnico di Milano IEEE Student Branch - <a href="https://www.ieee.org/membership/women/">WIE</a> as a student member</span>
  </li>
  <li>
    <span class="date">sep. 20</span>
    <span class="activity">joined <a href="https://www.polifoniapolimi.it/">Polifonia</a> as a student member: after a few years i'm enthusiastically back to singing in a choir and performing on stage &lt;3</span>
  </li>
  <li>
    <span class="date">sep. 20</span>
    <span class="activity">got my BSc in Energy Engineering from Politecnico di Milano</span>
  </li>
  <li>
    <span class="date">jun. 20</span>
    <span class="activity">passed Neural Networks and Deep Learning - by DeepLearning.AI on Coursera</span>
  </li>
  <li>
    <span class="date">sep. 20</span>
    <span class="activity">mentee with <a href="https://leadthefuture.tech">Lead the Future</a></span>
  </li>
  <li>
    <span class="date">sep. 19</span>
    <span class="activity">in Munich for the next six months for an Erasmus at TUM - Machinenwesen Dept.</span>
  </li>
  <li>
    <span class="date">jun. 19</span>
    <span class="activity">my first time in San Francisco for NGCX with <a href="https://necst.it/">NECSTLab</a>! I got to present my work at Facebook and at the Lawrence Berkeley National Laboratory.</span>
  </li>
  <li>
    <span class="date">mar. 19</span>
    <span class="activity">in Florence to be a student volunteer at DATE'19</span>
  </li>
  <li>
    <span class="date">mar. 18</span>
    <span class="activity">joined <a href="https://necst.it/">NECSTLab</a> as a research student</span>
  </li>
  <li>
    <span class="date">july 17</span>
    <span class="activity">graduated high school: after spending 5 years learning about ancient greek, latin and philosophy i'm now off to engineering school :)</span>
  </li>
  <li>
    <span class="date">july 17</span>
    <span class="activity">passed Cambridge Proficiency English - CEFR C2 (and failed Goethe Zertifikat C1 - CEFR C1)</span>
  </li>
  <li>
    <span class="date">july 16</span>
    <span class="activity">passed Goethe Zertifikat B2 - CEFR B2</span>
  </li>
  <li>
    <span class="date">sep. 16</span>
    <span class="activity">in Trento to take part in the NASA Challenge, with our project to <a href="http://www.ghiacciaitrentini.altervista.org/">map of alpine glaciers</a>!</span>
  </li>
</ul>

<div class="timeline-controls">
  <button id="timeline-toggle" class="expand-button"></button>
</div>

<style>
  /* --- Alignment Styles (from previous step) --- */
  .timeline {
    list-style: none; /* Remove bullet points */
    padding: 0;
    margin: 1.5rem 0;
  }
  
  .timeline li {
    display: grid;
    grid-template-columns: 90px 1fr; /* Fixed width for alignment */
    gap: 1rem;
    padding: 0.25rem 0;
  }

  .timeline .date {
    display: block; 
    font-weight: bold; 
    text-align: right; 
    color: #4b5563; 
    
  }
  

  
  .timeline-controls {
    text-align: left; /* Align button to the left */
    margin-top: 1rem;
  }
  
  .expand-button {
    background: none;
    border: 1px solid #14591D; /* Add a subtle border */
    padding: 0.5rem 1rem;
    cursor: pointer;
    font-size: 1rem;
    color: #4b5563; /* Match date color */
    border-radius: 4px;
    transition: background-color 0.2s;
  }

  .expand-button:hover {
    background-color: #14591D;
  }
</style>