ROOT=$(
  cd $(dirname $0)
  pwd
)

if [ -d "$HOME/.config/shell" ]; then
  mkdir -p $HOME/.config/shell
fi

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
ln -s $ROOT/bash_profile $HOME/.bash_profile
ln -s $ROOT/bashrc $HOME/.bashrc
ln -s $ROOT/aliases $HOME/.config/shell/aliases
ln -s $ROOT/tmux.conf $HOME/.tmux.conf
ln -s $ROOT/screenrc $HOME/.screenrc
ln -s $ROOT/zshrc $HOME/.zshrc
ln -s $ROOT/zpreztorc $HOME/.zpreztorc

# Neovim
if [ ! -d "$HOME/.config/nvim/lua" ]; then
  mkdir -p $HOME/.config/nvim/lua
fi
ln -s $ROOT/nvim/init.lua $HOME/.config/nvim/init.lua
ln -s $ROOT/nvim/lazy-lock.json $HOME/.config/nvim/lazy-lock.json
ln -s $ROOT/nvim/lua/autocmds.lua $HOME/.config/nvim/lua/autocmds.lua
ln -s $ROOT/nvim/lua/keymaps.lua $HOME/.config/nvim/lua/keymaps.lua
ln -s $ROOT/nvim/lua/options.lua $HOME/.config/nvim/lua/options.lua
ln -s $ROOT/nvim/lua/plugins.lua $HOME/.config/nvim/lua/plugins.lua
ln -s $ROOT/nvim/lua/base.lua $HOME/.config/nvim/lua/base.lua
ln -s $ROOT/nvim/lua/colorscheme.lua $HOME/.config/nvim/lua/colorscheme.lua
ln -s $ROOT/nvim/lua/coc.lua $HOME/.config/nvim/lua/coc.lua
