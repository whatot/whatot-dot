# managed by chezmoi

if command -q mise
    mise activate fish --quiet --shims | source
end

# mbx defers to an inherited RUSTC_WRAPPER, so drop the old sccache default.
if set -q RUSTC_WRAPPER; and test "$RUSTC_WRAPPER" = sccache
    set -e RUSTC_WRAPPER
end
if set -q CODEX_SANDBOX; and not set -q MBX_DISABLE
    set -gx MBX_DISABLE 1
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
