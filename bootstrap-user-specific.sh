#!/bin/env bash
# set -e

# install tools
brew update
brew upgrade
brew install kubectl argocd helm fnm

# set node env
fnm install --lts
fnm default lts-latest
eval "$(fnm env --use-on-cd)"
fnm use lts-latest
