# Find python file
export alias pyfind = ^find . -name "*.py"

# Grep among .py files
export alias pygrep = grep -nr --include="*.py"

# Share local directory as a HTTP server
export alias pyserver = python3 -m http.server
