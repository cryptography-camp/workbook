# Crypto Workbook

## Compiling

```sh
latexmk             # Compile the document
```

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
4. We give the participants a fixed time to work through the section in the workbook. We suggest to first read the section in silence, make notes, and then discuss with the partner. They solve the exercises classically with pencil, eraser and paper. If there are questions or a group is stuck, they raise their hands and a TA heads over. If there is an error in the workbook, or a clarification is needed, or if the same question is asked multiple times, we will temporarily stop the group work phase and try to address this for everyone. We also have the chance to update the workbook/solutionbook on github.
5. If a group is done with the "mandatory" exercises, they work on optional exercises.
6. If the exercise time is over, we ask the duos to hold up cards to indicate whether they are done with the exercise. If less than 50% are done, we extend the time.
7. We pair two neighboring duos to form a quad (ideally, at least one is finished with the exercises). They are given a fixed time to compare their answers.
8. Traffic light survey to see if enough quads have finished. Ask for a volunteer quad to present the solutions. If there are no volunteers, select randomly. Presenting solutions means that for each exercise we do the traffic light to see how deep we should go into the solutions. Make sure to let quads who showed a red card ask questions. Note that the solutions are also in the solutionbook.
9. If the day is over, do a "reflection sticky-note wall". Hand out blue and orange sticky notes and marker. Orange = "Still fuzzy about", blue = "aha moment/insight". Give 2 minutes, then take a few minutes to group sticky notes. Then do "synthesis panel" (for about 15 minutes) consisting of a lecturer, a moderator TA and two participant volunteers. The idea is summarize the day (what have we done, what is important), react to the sticky notes and allow for questions. Start the next day with 1.
10. If half a day has passed since assigning groups, it is a good time to reshuffle and go back to 2. Otherwise go to 3.

At the end, ask if people want to work on optional exercises.

### TODO
- Figure out how to do yesterday recap quiz ("kahoot"?)
- Workbook
    - Make sure exercises are structured such that presenting solutions doesn't take longer than 20 minutes...
    - Make sure to have "Explain in your own words exercises"
    - Have mandatory and optional exercises for groups that finish early.
