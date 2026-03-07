if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

function load-env
    for line in (cat $argv)
        if test -z "$line"; or string match -q '#*' $line
            continue
        end
        set key (string split -m1 '=' $line)[1]
        set val (string split -m1 '=' $line)[2]
        set -gx $key $val
    end
end

function start
    for venv in env .venv venv
        if test -f $venv/bin/activate.fish
            source $venv/bin/activate.fish
            break
        end
    end

    if test -f .env
        load-env .env
    end
end

fish_add_path $HOME/.local/bin
