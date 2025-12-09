
# yt-dlp-functions.nu
# Functional aliases for easy yt-dlp usage

# Play the most recently created file in VLC
export def play_latest [] {
  # Find the most recently created file in current directory
  let latest_file = (
    ls 
    | where type == file 
    | sort-by modified 
    | reverse 
    | first 
    | get name
  )
  
  if ($latest_file | is-empty) {
    print "No files found in current directory"
    return
  }
  
  print $"Playing: ($latest_file)"
  ^vlc --rate 1.33 $latest_file
}

# List formats and prompt for which one(s) to download
export def ytf [url: string] {
  # Check if ffmpeg is available
  if (which ffmpeg | is-empty) {
    print "Error: ffmpeg not found. Please install ffmpeg."
    return
  }
  
  # Get format list from yt-dlp (or ytnpl if that's your alias)
  let formats = (^yt-dlp --list-formats $url)
  
  # Display formats that are NOT audio-only or video-only (combined formats)
  print "=== Combined formats (audio+video) ==="
  $formats | lines | where {|line| 
    not ($line | str contains "(audio only)") 
    not ($line | str contains "(video only)")
  } | each {|line| print $line}
  
  print ""
  
  # Display audio-only formats
  print "=== Audio-only formats ==="
  $formats | lines | where {|line| 
    $line | str contains "(audio only)"
  } | each {|line| print $line}
  
  print ""
  
  # Display video-only formats
  print "=== Video-only formats ==="
  $formats | lines | where {|line| 
    $line | str contains "(video only)"
  } | each {|line| print $line}
  
  print ""
  
  # Prompt user for format code
  print "== Please enter a 'format code' (or vid+aud like '137+140') =="
  let format = (input "Format: ")
  
  # Download with selected format
  ^yt-dlp --format $format $url
  
  # Play the downloaded file
  play_latest
}

# Download to /tmp and play immediately (using ytp)
export def yw [url: string] {
  cd /tmp
  
  # Assuming 'ytp' is an alias for yt-dlp with specific options
  # Replace with actual yt-dlp command if needed
  if (which ytp | is-not-empty) {
    ^ytp $url
  } else {
    ^yt-dlp $url
  }
  
  play_latest
}

# Download to /tmp and play immediately (using yth)
export def yww [url: string] {
  cd /tmp
  
  # Assuming 'yth' is an alias for yt-dlp with specific options
  # Replace with actual yt-dlp command if needed
  if (which yth | is-not-empty) {
    ^yth $url
  } else {
    ^yt-dlp $url
  }
  
  play_latest
}
