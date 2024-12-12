# config edit and save
alias esrc="vi ~/.zshrc"
alias src="source ~/.zshrc ~/.zprofile"

# misc commands
alias tcp="tee >(pbcopy)"
alias e="vi"

# Docker
alias dcols="cat docker-compose.yml| yq '.services[]|key'"

# AWS
alias s3download="tr -d ',' | tr -d ' ' | tr -s '\n' | tr -d \\' | while read s; do echo \$s; aws s3 cp \$s .; done"

# Gets lag from a kafka consumer group description
alias slag="awk '{print \$6}' | egrep '[0-9]+' | awk '{sum += \$1} END {print sum}'"

# override vim
alias vim="nvim"
alias vi="nvim"
alias oldvim="/usr/bin/vim"

# lazygit
alias gg="lazygit"

# sketchybar
alias bar="sketchybar --reload"

# gradle stuff
alias gradle="./gradlew"
alias gspot="gradle spotlessApply"
alias gclean="gradle clean"
alias gbuild="gradle spotlessApply clean build"
alias gtest="gradle test"
