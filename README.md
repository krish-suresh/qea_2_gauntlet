# qea_2_gauntlet
Code and project files for the Quantitative Engineering Analysis 2 Final Project

Krishna Suresh, James Jagielski, and Evan Lockwood 
4/30/2022 - 5/10/2022

## Demos
https://user-images.githubusercontent.com/12313362/188755271-4c545227-b54e-4678-b1b7-0310fe60eb36.mp4


## Objective

The objective of this project was to drive a NEATO robot
through a room from a start position to a target zone. For this project that was the Barrel of Benevolence.
The rest of the objects in the contained area were obstacles that the NEATO had to avoid.

## Levels
This project was split into levels of difficulty where we removed information avalible for navigation at each level.

### Level 1
**Task:** Known map, start position, end position, obstacles
**Method:** Calculate a gradient field based on walls, obstacles and goal position. Numerically solved function gradient for parametric. Follow parametric using Frenet–Serret vectors.
**Result:**
[Level 1 Simulated](https://youtu.be/NFeCK1asEgA)
Script: `level1.m`
[Level 1 Real](https://youtu.be/Mn4Eejh6czI)
Script: `level1Real.m`

### Level 2
**Task:**
**Method:**
**Result:**

### Level 3
**Task:**
**Method:**
**Result:**

### Level 4
**Task:**
**Method:**
**Result:**
### Level 5
**Task:** Unknown robot starting position
**Method:**

<img src="https://github.com/krish-suresh/qea_2_gauntlet/blob/main/figures/l5init.png?raw=true" width="200">
<img src="https://github.com/krish-suresh/qea_2_gauntlet/blob/main/figures/l5resample.png?raw=true" width="200">
<img src="https://github.com/krish-suresh/qea_2_gauntlet/blob/main/figures/l5pfconv.png?raw=true" width="200">

**Result:**

[Particle Filter Convergence](https://youtu.be/AU7KtgtKHsI)

## Report
[Final_Report.pdf](https://github.com/krish-suresh/qea_2_gauntlet/blob/main/Report.pdf)
