#!/bin/bash
# run_agent.sh - Improved ALF execution script with enhanced debugging

LOG_FILE="agent.log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "--- Agent Iteration Started: $(date) ---"
echo "Environment Check:"
echo "  User: $(whoami)"
echo "  Path: $PATH"
echo "  Gemini CLI: $(gemini --version 2>&1 || echo 'NOT FOUND')"
echo "  Membrix API: ${GEMINI_API_KEY:+'Set (HIDDEN)' : 'NOT SET'}"

# 1. Prepare Prompt
echo "Preparing optimization prompt..."
PROMPT="You are an algorithmic optimization expert.
Read the strategy in program.md:
$(cat program.md)

Here is the current solver code:
$(cat solver.py)

Analyze the algorithm. Propose an optimization.
Return ONLY valid Python code to replace solver.py. Do not use markdown blocks, just the raw code."

# 2. Run Gemini CLI
echo "Calling Gemini CLI..."
RESULT_FILE="proposal.py"

# Capture the raw output
gemini ask "$PROMPT" --tools="membrix-mcp" > "$RESULT_FILE" 2> agent_stderr.log

EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
    echo "ERROR: Gemini CLI failed with exit code $EXIT_CODE"
    echo "Stderr log content:"
    cat agent_stderr.log
    exit $EXIT_CODE
fi

# 3. Clean and Validate Result using Python for safety
python3 - <<EOF
import re
import sys

try:
    with open("$RESULT_FILE", "r") as f:
        content = f.read()

    # Extract code from markdown block if present
    match = re.search(r'\`\`\`python\n(.*?)\n\`\`\`', content, re.DOTALL)
    if not match:
        match = re.search(r'\`\`\`\n(.*?)\n\`\`\`', content, re.DOTALL)
    
    code = match.group(1) if match else content.strip()

    if "def " in code or "import " in code:
        with open("solver.py", "w") as f:
            f.write(code)
        print("SUCCESS: solver.py updated.")
    else:
        print("WARNING: Unrecognized output format. No update applied.")
        print("Raw output sample (first 100 chars):")
        print(code[:100])
except Exception as e:
    print(f"ERROR: Failed to process agent output: {e}")
    sys.exit(1)
EOF

echo "--- Agent Iteration Finished ---"
