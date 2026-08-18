function pyclean
    set -l dirs $argv
    if test (count $dirs) -eq 0
        set dirs .
    end

    # Remove Python bytecode files (*.pyc and *.pyo)
    for dir in $dirs
        find $dir -type f -name '*.py[co]' -delete
        find $dir -type d -name '__pycache__' -delete
        find $dir -depth -type d -name '.mypy_cache' -exec rm -r '{}' +
        find $dir -depth -type d -name '.pytest_cache' -exec rm -r '{}' +
    end
end
