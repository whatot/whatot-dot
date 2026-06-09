# managed by chezmoi

function rtk
    switch "$argv[1]"
        case aws helm
            command $argv
        case '*'
            command rtk $argv
    end
end
