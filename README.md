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


