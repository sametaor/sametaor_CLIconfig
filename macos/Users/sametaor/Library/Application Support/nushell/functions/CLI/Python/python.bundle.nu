def pyclean [...dirs: string] {
  let search_dirs = if ($dirs | is-empty) { ["."] } else { $dirs }
  
  $search_dirs | each { |dir|
    # Clean all cache files and directories
    [
      $"($dir)/**/*.pyc",
      $"($dir)/**/*.pyo",
      $"($dir)/**/__pycache__",
      $"($dir)/**/.mypy_cache",
      $"($dir)/**/.pytest_cache"
    ] | each { |pattern|
      glob $pattern | each { |item| rm -rf $item }
    }
  }
  
  print "Python cache files cleaned successfully"
}
