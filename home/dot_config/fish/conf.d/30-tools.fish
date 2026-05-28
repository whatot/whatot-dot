# managed by chezmoi

if command -q mise
    mise activate fish --quiet --shims | source
end

if not set -q RUSTC_WRAPPER; and command -q sccache
    set -gx RUSTC_WRAPPER sccache
end

if status is-interactive
    set -l orbstack_completion_dir /Applications/OrbStack.app/Contents/Resources/completions/fish
    if test -d "$orbstack_completion_dir"; and not contains -- "$orbstack_completion_dir" $fish_complete_path
        set -ga fish_complete_path "$orbstack_completion_dir"
    end

    if command -q zoxide
        zoxide init fish | source
    end

    if command -q direnv
        direnv hook fish | source
    end
end
