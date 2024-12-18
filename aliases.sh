# config edit and save
alias esrc="vi ~/.zshrc"
alias src="source ~/.zshrc ~/.zprofile"

# misc commands
alias tcp="tee >(pbcopy)"
alias igrep="grep -i"

# Docker
alias dcols="cat docker-compose.yml| yq '.services[]|key'"

# AWS
alias s3download="tr -d ',' | tr -d ' ' | tr -s '\n' | tr -d \\' | while read s; do echo \$s; aws s3 cp \$s .; done"
alias iamgod="export AWS_DEFAULT_PROFILE=admin"

# Gets lag from a kafka consumer group description
alias slag="awk '{print \$6}' | egrep '[0-9]+' | awk '{sum += \$1} END {print sum}'"

# override vim
alias vim="nvim"
alias vi="nvim"
alias oldvim="/usr/bin/vim"
alias e="vi"

# lazygit
alias gg="lazygit"

# sketchybar
alias bar="sketchybar --reload"

# gradle stuff
alias gw="./gradlew"
alias gspa="gw spotlessApply"
alias gclean="gw clean"
alias gbuild="gw spotlessApply clean build"
alias gtest="gw test"
