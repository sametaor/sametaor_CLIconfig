
# magnet_to_torrent.nu

export def magnet_to_torrent [
  magnet_link: string  # Magnet link to convert
] {
  # Extract hash using regex
  let hash_match = ($magnet_link | parse --regex 'xt=urn:btih:(?P<hash>[^&/]+)')
  
  if ($hash_match | is-empty) {
    print -e "Error: Invalid magnet link (no info hash found)"
    return 1
  }
  
  let hash = ($hash_match | first | get hash)
  
  # Extract display name if present
  let filename = try {
    let dn_match = ($magnet_link | parse --regex 'dn=(?P<name>[^&/]+)')
    if ($dn_match | is-not-empty) {
      # URL decode the filename
      $dn_match | first | get name | str replace --all '%20' ' '
    } else {
      $hash
    }
  } catch {
    $hash
  }
  
  # Create torrent file content
  let length = ($magnet_link | str length)
  let content = $"d10:magnet-uri($length):($magnet_link)e"
  
  # Write to file
  $content | save -f $"($filename).torrent"
  
  print $"Created: ($filename).torrent"
}
