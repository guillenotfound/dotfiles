# Zsh Shell Startup Optimization Guide

## Current Performance
- **Before optimizations**: ~250ms
- **After initial optimizations**: ~198ms  
- **After all optimizations**: ~148ms ✅
- **Other computer (no CrowdStrike)**: ~90ms
- **Target achieved**: Near-optimal for CrowdStrike environment!

## Optimizations Applied ✅

### 1. Replace `brew shellenv` with static exports (-50ms)
Changed from:
```zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

To static exports in `~/.dotfiles/zprofile` (see lines 8-16).

**Why**: Running `brew shellenv` is a Ruby script that takes ~50ms each time.

**Maintenance**: If Homebrew changes location, regenerate with:
```bash
/opt/homebrew/bin/brew shellenv
```

### 2. Cache vivid output (-10ms)
Now caches the vivid theme to `~/.cache/vivid-snazzy.sh` and only regenerates when the theme file changes.

### 3. Compile zsh config files (-5ms)
Compiled files:
- `~/.dotfiles/zshrc.zwc`
- `~/.dotfiles/zshenv.zwc`
- `~/.dotfiles/zprofile.zwc`
- `~/.dotfiles/aliases.sh.zwc`

**Regenerate after editing**:
```bash
cd ~/.dotfiles
zcompile -R zshrc.zwc zshrc
zcompile -R zshenv.zwc zshenv
zcompile -R zprofile.zwc zprofile
zcompile -R aliases.sh.zwc aliases.sh
```

### 4. Generate static init files (-25ms) ✨ NEW
Instead of running `atuin`, `starship`, `zoxide`, and `fzf` commands on every shell startup, we cache their output.

**Script created**: `~/.dotfiles/scripts/generate-static-inits.sh`

**Regenerate after updating tools**:
```bash
~/.dotfiles/scripts/generate-static-inits.sh
```

This replaces expensive `eval "$(command init ...)"` calls with simple `source` statements.

### 5. Replace cargo env with static PATH (-6ms)
Changed from:
```zsh
. "$HOME/.cargo/env"
```

To:
```zsh
export PATH="$HOME/.cargo/bin:$PATH"
```

This eliminates one file source operation.

## Additional Optimizations (Not Yet Applied)

### 4. Defer atuin initialization (-40ms)
**Current cost**: ~42ms

Atuin's `_atuin_preexec` hook is expensive. Consider:

**Option A**: Defer atuin loading
```zsh
# In ~/.dotfiles/zshrc, replace:
eval "$(atuin init zsh --disable-up-arrow)"

# With lazy loading:
atuin() {
  unfunction atuin
  eval "$(command atuin init zsh --disable-up-arrow)"
  atuin "$@"
}
```

**Option B**: Disable if you don't use it heavily
```zsh
# Comment out in ~/.dotfiles/zshrc line 101
# eval "$(atuin init zsh --disable-up-arrow)"
```

### 5. Lazy-load starship prompt (-10ms)
**Current cost**: ~10-15ms

```zsh
# Replace in ~/.dotfiles/zshrc line 102:
eval "$(starship init zsh)"

# With:
if [[ -z "$STARSHIP_SHELL" ]]; then
  eval "$(starship init zsh)"
fi
```

Or use a simple PS1 for non-interactive shells.

### 6. Reduce completion files
**Current cost**: ~18ms for compinit

Check installed completions:
```bash
ls /opt/homebrew/share/zsh/site-functions | wc -l
```

Remove completions for tools you don't use:
```bash
# Example: if you don't use argo
rm /opt/homebrew/share/zsh/site-functions/_argo
```

Then regenerate completion dump:
```bash
rm ~/.zcompdump
compinit
```

### 7. Optimize plugin loading order
Load expensive plugins last so your shell appears faster:
- Fast plugins (autosuggestions, syntax highlighting)
- Medium (forgit, fzf)
- Slow (atuin, starship) ← these make the shell "feel" slow

### 8. Remove unnecessary plugins
Review what you actually use:
- `hhighlighter` - Do you use the `h` command often?
- `forgit` - Do you use git fzf integration?
- `extract` plugin from oh-my-zsh

### 9. Profile your shell startup
Use this command to see what's slow:
```bash
time ( zsh -i -c exit )
```

Or detailed profiling:
```bash
cat > /tmp/profile.zsh << 'EOF'
zmodload zsh/zprof
source ~/.zprofile
source ~/.zshenv  
source ~/.zshrc
zprof
EOF
zsh /tmp/profile.zsh
```

### 10. Benchmark tools
```bash
# Quick test
time zsh -i -c exit

# Multiple runs with hyperfine
hyperfine --warmup 2 --runs 10 'zsh -i -c exit'

# Detailed millisecond breakdown
zmodload zsh/datetime
start=$EPOCHREALTIME
zsh -i -c exit
echo "$(( (EPOCHREALTIME - start) * 1000 )) ms"
```

## Maintenance

### After updating dotfiles
1. Recompile changed files:
```bash
cd ~/.dotfiles
zcompile -R zshrc.zwc zshrc
```

2. Regenerate vivid cache if you change themes:
```bash
rm ~/.cache/vivid-snazzy.sh
```

3. Clear completion cache if you install/remove tools:
```bash
rm ~/.zcompdump
```

### After Homebrew updates
If Homebrew moves (unlikely), update the static exports in `~/.dotfiles/zprofile`:
```bash
/opt/homebrew/bin/brew shellenv
```

## Performance Targets

| Component | Before | After Initial | After All | Notes |
|-----------|--------|---------------|-----------|-------|
| zprofile | 82ms | 31ms | 8ms | ✅ Optimized! |
| zshenv | 0.4ms | 0.4ms | 0.4ms | ✅ Already fast |
| zshrc | 140ms | 140ms | 122ms | ✅ Optimized! |
| **Total** | **250ms** | **198ms** | **148ms** | **🎉 41% faster!** |

## Comparison with Other Computer

Your other computer runs at ~100ms. Possible reasons it's faster:
1. **Fewer installed tools** → fewer completion files
2. **Different plugins** → maybe not using atuin
3. **Better I/O** → faster SSD or less disk fragmentation
4. **Cached files** → all .zwc files properly compiled

To match it, focus on:
- Deferring/removing atuin (-42ms)
- Optimizing compinit (-10ms)  
- Removing unused plugins (-20ms)
- Lazy-loading heavy tools (-20ms)

That would get you to ~106ms, matching your other machine!
