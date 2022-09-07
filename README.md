# qea_2_gauntlet
Code and project files for the Quantitative Engineering Analysis 2 Final Project

Krishna Suresh, James Jagielski, and Evan Lockwood 
4/30/2022 - 5/10/2022

## Demos
Particle Filter:

<img src="https://user-images.githubusercontent.com/12313362/188762424-5753ee49-ad8f-4a01-aa73-c6bb9231e1ed.gif" width="400">

RRT*:

<img src="https://user-images.githubusercontent.com/12313362/188762426-68bb4d27-e127-4f2b-88b3-1e0d66bdf481.gif" width="400">

Potential field gradient:

https://user-images.githubusercontent.com/12313362/188755271-4c545227-b54e-4678-b1b7-0310fe60eb36.mp4


## Objective

The objective of this project was to drive a NEATO robot vacuum through a room from a start position to a target zone (the cylinder) while avoiding the obstacles (the boxes and walls).


## Levels
This project was split into levels of difficulty where we removed information available for navigation at each level.

### Level 1
**Task:** Navigate to cylinder given map, start position, end position, obstacles.

**Method:** 
1. Calculate a potential field based on walls, obstacles and goal position
2. Numerically solved function gradient for parametric. 
3. Follow parametric using Frenet–Serret vectors and apply PIDVA control system

**Result:**

[Level 1 Simulated](https://youtu.be/NFeCK1asEgA)  Script: `level1.m`

[Level 1 Real](https://youtu.be/Mn4Eejh6czI)  Script: `level1Real.m`

### Level 2
**Task:** Navigate to cylinder given start position and end position.

**Method:**
1. Place robots at random locations in room and read LIDAR data or collect scans during navigation
2. Prune data and apply RANSAC classifier to detect edges
3. Generate potential field function based on target location and obstacles
4. Follow gradient similar to level1

**Result:**

[Level 2 Simulated](https://youtu.be/8qSnKJWeX7Y)  Script: `level2.m`

### Level 3
**Task:** Navigate to cylinder given start position and cylinder size.

**Method:**
1. Use similar data capture and obstacle fitting as with level2
2. Fit circle to remaining lidar data using RANSAC
3. Once circle position is found plan path using gradient method from level1

**Result:**

[Level 3 Simulated](https://youtu.be/gT6xqtORS8M)  Script: `level3.m`

### Level 4
**Task:** Navigate to cylinder with _near-optimial_ path given start position and end position.

**Method:**
1. Use RRT* to plan near optimal path to goal
2. Follow path using pure pursuit controller 

**Result:**

[Level 4 Simulated](https://youtu.be/6I-wDSB1Pvc)  Script: `level4.m`
[Level 4 RRT*](https://youtu.be/1bTS1ah9bO4)  Script: `testrrtstar.m`


### Level 5
**Task:** Navigate to cylinder with goal location and map (no start position).

**Method:**
1. Use a particle filter to localize robot using lidar data.
2. Once particles have converged, plan to goal with RRT*
3. Navigate to target using optimal path

<img src="https://github.com/krish-suresh/qea_2_gauntlet/blob/main/figures/l5init.png?raw=true" width="200">
<img src="https://github.com/krish-suresh/qea_2_gauntlet/blob/main/figures/l5resample.png?raw=true" width="200">
<img src="https://github.com/krish-suresh/qea_2_gauntlet/blob/main/figures/l5pfconv.png?raw=true" width="200">

**Result:**

[Particle Filter Convergence](https://youtu.be/AU7KtgtKHsI)  Script: `level5.m`

## Report
[Final_Report.pdf](https://github.com/krish-suresh/qea_2_gauntlet/blob/main/Report.pdf)
