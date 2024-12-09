def _install_dotfiles() {
  echo "Installing sketchybar config"
  rm -rf ~/.config/sketchybar
  ln -s $LUMEN_DOTFILES/sketchybar ~/.config/sketchybar

  echo "Installing nvim"
  rm -rf ~/.config/nvim
  ln -s $LUMEN_DOTFILES/nvim ~/.config/nvim
  
  echo "Installing aerospace"
  rm -rf ~/.aerospace.toml
  ln -s $LUMEN_DOTFILES/aerospace/.aerospace.toml ~/.aerospace.toml

  chmod +x $LUMEN/**/*.sh
}
