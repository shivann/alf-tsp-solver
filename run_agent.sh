#!/bin/bash
# run_agent.sh - The ALF execution script that uses the Gemini CLI

# 1. Provide context to the Gemini CLI and ask for a modification
echo "Running Gemini CLI to propose an optimization..."

# Ask gemini to propose a better algorithm
python_code=$(gemini ask "You are optimizing a Traveling Salesperson Algorithm.
Read the strategy in program.md:
$(cat program.md)

Here is the current solver code:
$(cat solver.py)

Analyze the algorithm. Propose an optimization.
Return ONLY valid Python code to replace solver.py. Do not use markdown blocks, just the raw code." --tools="membrix-mcp")

# 2. Apply the modification
if [ ! -z "$python_code" ]; then
    echo "$python_code" > solver.py
    echo "Agent modification applied."
else
    echo "No modification proposed by agent."
fi
