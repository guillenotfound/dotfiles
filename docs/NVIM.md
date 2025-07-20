# Neovim cheat sheet

## Prerequisites

```sh
brew install luarocs
```

## Lazyvim specific

- `gco` - Add comment below
- `gcO` - Add comment above
- `<leader>xq` - Quickfix list
- `[q` - Previous element quickfix
- `]q` - Next element quickfix
- `<leader>cd` - Line diagnostics (`CTRL-W d` or `CTRL-W CTRL-D` does the same thing)

## Neovim

- Using another config `NVIM_APPNAME=<folder> nvim`, where folder has to be a directory inside `~/.config`
- `g;` - Go to N older position in change list
- `g,` - Go to N newer position in change list
- `'.` - Jump to the position where the last change was made
- `gw` - Line wrap
- `CTRL-W ]` or `CTRL-W CTRL-]` - Split current window horizontally and go to definition
- `]s [s` - Go to next/previous spell error
- `}` - Jump to the next paragraph

## ToDo

- Reference dotfiles:
  - [https://github.com/MariaSolOs/dotfiles/tree/main/.config/nvim](https://github.com/MariaSolOs/dotfiles/tree/main/.config/nvim)
  - [https://github.com/folke/dot](https://github.com/folke/dot)

- Try out
  - [https://github.com/yetone/avante.nvim?tab=readme-ov-file](https://github.com/yetone/avante.nvim?tab=readme-ov-file)
  - [https://github.com/Robitx/gp.nvim](https://github.com/Robitx/gp.nvim)
  - [https://www.reddit.com/r/neovim/comments/12aek0y/ai_plugin_overview/](https://www.reddit.com/r/neovim/comments/12aek0y/ai_plugin_overview/)
- [https://kezhenxu94.me/blog/lazyvim-project-specific-settings](https://kezhenxu94.me/blog/lazyvim-project-specific-settings)
- [https://www.reddit.com/r/neovim/comments/st1kxs/comment/hx1cge9/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button](https://www.reddit.com/r/neovim/comments/st1kxs/comment/hx1cge9/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
- [https://github.com/iggredible/Learn-Vim/blob/31dd425645d8d057013a76b66ffbb82b9ac8ecd1/ch05_moving_in_file.md?plain=1#L218-L229](https://github.com/iggredible/Learn-Vim/blob/31dd425645d8d057013a76b66ffbb82b9ac8ecd1/ch05_moving_in_file.md?plain=1#L218-L229)

- [https://www.youtube.com/watch?v=fFHlfbKVi30&t=2s](https://www.youtube.com/watch?v=fFHlfbKVi30&t=2s)
- bufdo
