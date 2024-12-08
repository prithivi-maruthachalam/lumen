def _install_dotfiles() {
  echo "Installing dotfiles..."

  echo "Installing sketchybar config"
  rm -rf ~/.config/sketchybar
  ln -s $LUMEN/dotfiles/sketchybar ~/.config/sketchybar

  echo "Installing nvim"
  rm -rf ~/.config/nvim
  ln -s $LUMEN/dotfiles/nvim ~/.config/nvim
  
  echo "Installing aerospace"
  rm -rf ~/.aerospace.toml
  ln -s $LUMEN/dotfiles/aerospace/.aerospace.toml ~/.aerospace.toml
}
