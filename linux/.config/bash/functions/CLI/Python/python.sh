# python.sh — Bash function to clean Python bytecode and caches
pyclean() {
  # Remove .pyc and .pyo files
  find "${@:-.}" -type f -name "*.py[co]" -delete
  # Remove __pycache__ directories
  find "${@:-.}" -type d -name "__pycache__" -exec rm -r "{}" +
  # Remove .mypy_cache directories
  find "${@:-.}" -depth -type d -name ".mypy_cache" -exec rm -r "{}" +
  # Remove .pytest_cache directories
  find "${@:-.}" -depth -type d -name ".pytest_cache" -exec rm -r "{}" +
}