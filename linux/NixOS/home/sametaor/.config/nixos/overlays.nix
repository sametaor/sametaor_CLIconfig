{ inputs }:
[
  inputs.millennium.overlays.default
  inputs.nur.overlays.default
  inputs.prismnix.overlays.default
  inputs.nixpkgs-wayland.overlay
  (final: prev: { contour = prev.runCommand "contour-dummy" { outputs = [ "out" "terminfo" ]; } ''mkdir -p $out $terminfo''; })
  (final: prev: {
    # Make nvidiaWrap available globally
    nvidiaWrap =
      pkg:
      final.symlinkJoin {
        name = "nvidia-${pkg.name}";
        paths = [ pkg ];
        nativeBuildInputs = [ final.makeBinaryWrapper ];
        postBuild = ''
          if [ -d "$out/bin" ]; then
            rm -rf $out/bin
            mkdir -p $out/bin
            for binary_path in ${pkg}/bin/*; do
              if [ -f "$binary_path" ] || [ -L "$binary_path" ]; then
                makeWrapper "$binary_path" "$out/bin/$(basename "$binary_path")" \
                  --set __NV_PRIME_RENDER_OFFLOAD 1 \
                  --set __NV_PRIME_RENDER_OFFLOAD_PROVIDER NVIDIA-G0 \
                  --set __GLX_VENDOR_LIBRARY_NAME nvidia \
                  --set __VK_LAYER_NV_optimus NVIDIA_only
              fi
            done
          fi

          if [ -d "$out/share/applications" ]; then
            rm -rf $out/share/applications
            mkdir -p $out/share/applications

            cp -r ${pkg}/share/applications/* $out/share/applications/
            chmod -R +w $out/share/applications

            for desktop in $out/share/applications/*.desktop; do
              if [ -f "$desktop" ]; then
                substituteInPlace "$desktop" --replace "Exec=" "Exec=nvidia-offload "
                substituteInPlace "$desktop" --replace "%u" "%U"  --replace "X-MultipleArgs=false" ""
              fi
            done
          fi
        '';
      };

    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (pythonFinal: pythonPrev: {
        click-threading = pythonPrev.click-threading.overridePythonAttrs (oldAttrs: {
          doCheck = false;
        });
      })
    ];
  })
]