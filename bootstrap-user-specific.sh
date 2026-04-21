#!/bin/env bash
# set -e

# install tools
brew update
brew upgrade
brew install kubectl argocd helm fnm

# set node env
fnm install -- --lts
fnm use -- --lts
