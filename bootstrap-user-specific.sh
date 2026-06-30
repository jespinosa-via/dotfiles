#!/bin/env bash
# set -e

# install tools
brew update
brew upgrade
brew install kubectl argocd helm fnm zsh aws

# set zsh as default shell
if ! grep -q "$(brew --prefix)/bin/zsh" /etc/shells; then
    echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
fi
chsh -s "$(brew --prefix)/bin/zsh"

# set node env
fnm install --lts
fnm default lts-latest
eval "$(fnm env --use-on-cd)"
fnm use lts-latest

# launch zsh
exec "$(brew --prefix)/bin/zsh"
