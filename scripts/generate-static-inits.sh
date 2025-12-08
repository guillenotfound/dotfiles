#!/bin/bash
# Generate static init files to avoid process spawns during shell startup
# This is especially important with CrowdStrike Falcon installed, as each
# process spawn adds ~5-7ms overhead.
#
# Run this script after updating: atuin, starship, zoxide, or fzf
# Then source the cached files instead of using eval "$(command init ...)"

set -e

CACHE_DIR="${HOME}/.cache/zsh-inits"
mkdir -p "$CACHE_DIR"

echo "Generating static init files..."
echo ""

# Cache atuin init
if command -v atuin &>/dev/null; then
    echo "✓ Generating atuin.zsh..."
    atuin init zsh --disable-up-arrow > "$CACHE_DIR/atuin.zsh"
else
    echo "⊘ atuin not found, skipping"
fi

# Cache starship init
if command -v starship &>/dev/null; then
    echo "✓ Generating starship.zsh..."
    starship init zsh > "$CACHE_DIR/starship.zsh"
else
    echo "⊘ starship not found, skipping"
fi

# Cache zoxide init
if command -v zoxide &>/dev/null; then
    echo "✓ Generating zoxide.zsh..."
    zoxide init zsh --no-cmd > "$CACHE_DIR/zoxide.zsh"
else
    echo "⊘ zoxide not found, skipping"
fi

# Cache fzf init
if command -v fzf &>/dev/null; then
    echo "✓ Generating fzf.zsh..."
    fzf --zsh > "$CACHE_DIR/fzf.zsh"
else
    echo "⊘ fzf not found, skipping"
fi

# Cache vivid colors (if not already using the cache method)
if command -v vivid &>/dev/null; then
    echo "✓ Generating vivid-snazzy.sh..."
    echo "export LS_COLORS='$(vivid generate snazzy)'" > "${HOME}/.cache/vivid-snazzy.sh"
else
    echo "⊘ vivid not found, skipping"
fi

echo ""
echo "Done! Static init files generated in: $CACHE_DIR"
echo ""
echo "To use these in your .zshrc, replace:"
echo "  eval \"\$(atuin init zsh --disable-up-arrow)\""
echo "  eval \"\$(starship init zsh)\""
echo "  eval \"\$(zoxide init zsh --no-cmd)\""
echo "  source <(fzf --zsh)"
echo ""
echo "With:"
echo "  source ~/.cache/zsh-inits/atuin.zsh"
echo "  source ~/.cache/zsh-inits/starship.zsh"
echo "  source ~/.cache/zsh-inits/zoxide.zsh"
echo "  source ~/.cache/zsh-inits/fzf.zsh"
echo ""
echo "Performance gain: ~20-30ms (especially with CrowdStrike Falcon)"
echo ""
echo "Remember to re-run this script after updating these tools!"
