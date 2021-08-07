#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

export PATH="/opt/homebrew/bin:$PATH"
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> $HOME/.zshrc

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i '' 's/robbyrussell/powerlevel10k\/powerlevel10k/g' ~/.zshrc

echo "Adding Scripts..."
chmod +x ./Scripts/d_accel
chmod +x ./Scripts/mount_disk
cp -R ./Scripts ~/Scripts
mkdir ~/Desktop/Shield
echo 'export PATH=$PATH:~/Scripts' >> $HOME/.zshrc

# Update homebrew recipes
brew update

# sudo vi /etc/shells
# add the path /usr/local/bin/bash
# comment out the others
# change to the new shell: chsh -s /usr/local/bin/bash

PACKAGES=(
    git
#   go   Golang needs to be installed with pkg.
    nvm
    pyenv
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing nvm..."
echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm'  >> $HOME/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> $HOME/.zshrc

CASKS=(
    docker
    google-chrome
    iterm2
    visual-studio-code
    calibre
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

echo "Installing fonts..."
brew tap homebrew/cask-fonts
FONTS=(
    font-fira-code-nerd-font
)
brew install --cask ${FONTS[@]}

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Bootstrapping complete"
