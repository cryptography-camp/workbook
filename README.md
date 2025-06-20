# Crypto Workbook

## Compiling

```sh
latexmk             # Compile the document
```

## Proposed Outline

**Goals**: Provide enough background to be able to

1. understand the DahLIAS paper
2. come up with security definitions of Silent Payments

**Outline (tentative**

1. Security notions & attacks
    1. Intro: notation, games asymptotic security
       Stress that all we're going to do do is building algorithms and analyzing them. We use a relatively straightforward flavor of pseudocode for that.
       - gap between not being able to break and security
       - what is security? need to come up with properties, add assumptions
       - TODO: note that there are alternatives for proving security

    2. collision resistance
    3. Commitments:
       - define syntax, completeness and security (binding and hiding)
       - Exercises:
         - hash based commitments are binding
         - also hiding under preimage resistance (can this be proven)?
         - define strong binding, commitment commits not only to message but also to randomness, why is that important for taproot (only for inner key)
    4. (Optional: Accumulators)
       - define syntax, completeness and security (binding and hiding)
       - Exercieses:
         merkle trees are secure (under collision resistance
    4. One-time signature schemes
       - define syntax, completeness and security
       - motivate signing oracle
       - lamport signatures are one time (under collision resistance)
       - need signing oracle
       - Exercise: justify why we the model includes a signing oracle
    5. (Optional: GGM)
    6. DLP
       - DDH
       - Exercise
         - if you break DDH you break DLP
         - DLP is hard in the GGM
           - How do we prove hardness of something like the DLP, which we know is not hard

         - DDH is hard in the GGM?
         - Assume you have a DL solver (quantum computer)
          1. Break Pedersen commitment binding
          2. Break Elgamal commitment hiding
         - el gamal commitments are hiding under the DLP
         - Exercise: Reducing pedersen to dlog
                aX + bG = a'X + b'G
                Find Dlog of x
       - OMDL
         - why is it hard?
         - How does it relate to the GGM?
         - AOMDL and falsifiability
         - Exercise: explain AOMDL

     7. (Diffie Helman)
        - exercise: reduce to DDH
     8. ROM
       - Exercise: Prove binding of Hash(msg, rand) in the ROM
         - stronger because it doesn't require p.p.t., but it requires number of queries to be small
       - hiding is stronger because it is statistic?
       - Exercise: Prove hiding of Taproot commitments
      - Exercise: Taproot commitments binding
     9. forking lemma and programmable rom
      - Forking lemma
        - Exercise: try an algorithm to evade it and bound it's success prob
     10. Signatures schemes
       - define syntax, completeness and security (EUF-CMA)
       - Exercises:
         1. Break Schnorr signature scheme with incorrect deterministic nonce generation, e.g. nonce = Hash(m)
         2. How do you fix that?
       - Exercise: Schnorr signature proof in the ROM ("fill-in-the-gaps")
       - add taproot tree to security model, maybe prove security
       - Exercise: define strongly binding model
     11. Signature schemes with tweaking
       - Why? We use "tweaking" for BIP32 and taproot
       - define tweaking and its security
       - Exercises:
         1. Break Schnorr signature without pubkey prefixing (i.e. where the challenge hash does not include the pubkey)
         2. How to fix that?
     12. Aggregate signature schemes
       - Why? Essentially, this is what we care about in Bitcoin. Maybe gets more relevant in a world of PQ signatures.
       - Define syntax, completeness and security of noninteractive aggregate signatures
       - Exercises
         1. Break a trivial aggsig scheme using Russell's attack
         2. How to fix that?
     13. Generalized birthday problem and ROS
        - Optional: the "ultimate" BLLOR attack in the DahLIAS paper (some people asked about how to break nested musig)
        - attack: show predecessor of musig and why it goes wrong

2. More optional ideas
   7.  Winternitz one-time signatures
      - Exercise: Prove ("fill-in-the-gaps") security
   8. Taproot is post quantum
   9. introduce algebraic group model (AGM)
   10.Schnorr signature proof in the ROM+AGM?
   13. Optional: AOMDL
   - for attacks: look at first versions of FROST (lol)
   - batch verfication and Schwartz-Zippel
   - negligible: what in Schnorr if r = 0 and we output the secret key


3. Silent Payments group project
   - Prerequisite: DDH assumption
    - Optional: exercise demonstrate DDH by proving IND-CPA of Elgamal encryption
   - Group project: Formalize syntax & security of silent payments
    - Present? (but then every group presents the same...)

4. Opening up
   - LN, FROST & MuSig, countersign?/p2p, post-quantum, silent payments



## Cryptocamp 2025

"Cryptocamp" is a 3.5 day event that attempts to teach developers the basics of provable cryptography. We have a workbook that consists of cryptographic definitions, propositions, proofs and exercises. The goal is to make the event interactive, fun and educational.

### Requirements
- Room with enough space to have groups of two that can work together without causing too much chaos.
- Projector to project the workbook on large screen.
- To share solutions to exercises, we'd ideally have an Ipad with Apple pen (or similar) connected to the projector. I can bring the Ipad.
- The workbook is a PDF with source code publicly available on github. There is an accompanying "solutionbook" that contains the solutions to the exercises. Since the workbook is a work-in-progress, it's best if the participants have a tabled/laptop to access to the online PDF.
- The participants have pencil, paper & eraser to solve the exercises.
- 3 to 4 teaching assistants that are able to help groups if they are stuck.
- Each duo gets a green, yellow and red card ("traffic light") that we use to gather feedback quickly.
- Blue and orange sticky notes, as well as thick markers and a wall to put them on.

### Algorithm
1. If this is not the first day, 15 minute "Yesterday recap quiz" (maybe 8 questions). Do this maybe using Kahoot.
2. Put each participant in a random group consisting of two participants ("duo"). Do this by letting participants count from 0. For pariticpant i, the assigned group is `i mod floor(n_participants/2)`. There may be a group with 3 participants. Each participant physically moves next to their group member.
3. A TA gives a short intro (5 minutes?) to the next workbook section, putting the relevant part of the workbook on the projector.
4. We give the participants a fixed time to work through the section in the workbook. They solve the exercises classically with pencil, eraser and paper. If there are questions or a group is stuck, they raise their hands and a TA heads over. If there is an error in the workbook, or a clarification is needed, or if the same question is asked multiple times, we will temporarily stop the group work phase and try to address this for everyone. We also have the chance to update the workbook/solutionbook on github.
5. If a group is done with the "mandatory" exercises, they work on optional exercises.
6. If the exercise time is over, we ask the duos to hold up cards to indicate whether they are done with the exercise. If less than 50% are done, we extend the time.
7. We pair two neighboring duos to form a quad (ideally, at least one is finished with the exercises). They are given a fixed time to compare their answers.
8. Traffic light survey to see if enough quads have finished. Ask for a volunteer quad to present the solutions. If there are no volunteers, select randomly. Presenting solutions means that for each exercise we do the traffic light to see how deep we should go into the solutions. Make sure to let quads who showed a red card ask questions. Note that the solutions are also in the solutionbook.
9. If the day is over, do a "reflection sticky-note wall". Hand out blue and orange sticky notes and marker. Orange = "Still fuzzy about", blue = "aha moment/insight". Give 2 minutes, then take a few minutes to group sticky notes. Then do "synthesis panel" (for about 15 minutes) consisting of a lecturer, a moderator TA and two participant volunteers. The idea is summarize the day (what have we done, what is important), react to the sticky notes and allow for questions. Start the next day with 1.
10. If half a day has passed since assigning groups, it is a good time to reshuffle and go back to 2. Otherwise go to 3.

### TODO
- Figure out how to do yesterday recap quiz ("kahoot"?)
- Workbook
    - Make sure exercises are structured such that presenting solutions doesn't take longer than 20 minutes...
    - Have mandatory and optional exercises for groups that finish early.
