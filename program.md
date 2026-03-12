# Traveling Salesperson Problem Optimizer

## Objective
You are an algorithmic optimization expert. Your goal is to modify `solver.py` to find the shortest possible route connecting all cities in `cities.json`. The evaluation script will run your code and score the total distance.

## Rules
1. You may ONLY modify `solver.py`.
2. Do NOT modify `eval.py` or `cities.json`.
3. Your `solve_tsp` function must output a valid list of city dictionaries containing all original cities exactly once.
4. The evaluation will timeout after 30 seconds. Do not write infinitely looping code.
5. If you decide to use advanced algorithms (e.g., Simulated Annealing, 2-opt, Genetic Algorithms, Nearest Neighbor), implement them entirely within `solver.py` without requiring external un-installed libraries besides standard Python math/itertools.

## Semantic Memory
Before you make any edits, query the Membrix semantic database. Learn which algorithms (e.g., basic nearest neighbor vs 2-opt) previous agents have already tried. Do not repeat failed experiments. If a previous agent successfully implemented 2-opt, your job is to branch off their code and introduce further optimizations (like 3-opt or simulated annealing parameters).
