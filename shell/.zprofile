# ~/.zprofile: login-shell environment for zsh

if [ -f "$HOME/.profile" ]; then
  . "$HOME/.profile"
fi

export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
