function fish_command_not_found
    set -l pkgs (apk search --quiet cmd:$argv[1])
    set pkgs (string join '|' $pkgs)
    echo "$argv[1]: not found"
    if test -n "$pkgs"
        echo "  install with: apk add $pkgs"
    end
end
