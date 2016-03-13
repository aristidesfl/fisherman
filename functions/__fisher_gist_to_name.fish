function __fisher_gist_to_name -a url
    set -l id (printf "%s\n" "$url" | sed 's|.*/||')
    set -l color (set_color $fish_color_match)
    set -l color_normal (set_color normal)
    
    set -l name (
        spin "curl -Ss https://api.github.com/gists/$id" -f "  $color@$color_normal\r" | awk '

        /"files": / { files++ }

        /"[^ ]+.fish": / && files {
            gsub("^ *\"|\.fish.*", "")
            print
        }
        '
    )

    if test -z "$name"
        return 1
    end

    printf "%s\n" $name
end
