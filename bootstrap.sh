# install xcode commad line utilities if not present
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# brew install more utils
brew install moreutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# adding coreutils to path
$PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

# installing oh-my-zsh
curl -L http://install.ohmyz.sh | sh

# installing terminal black theme
open IR_Black.terminal

# creating directories in HOME : Personalized
mkdir ~/Developer
mkdir ~/Projects
mkdir ~/bin

# moving all dotfiles to HOME
for f in $(gfind ./dotfiles/ -type f ! -name ".DS_Store"   -printf "%f\n"); do cp dotfiles/$f ~/\.$f;done;

# executing dotfiles
source ~/.osx
source ~/.zshrc
# installing java if not present
java -version

# adding tap for php
brew tap homebrew/php

# installing brew packages if list file available
if [  -f ./brew_packages.txt ]; then
   while read F  ; do
        brew install  $F
   done < ./brew_packages.txt 
else
    echo "File not found"

fi


# installing brew cask
brew install caskroom/cask/brew-cak

# installing brew cask apps if list file available
if [  -f ./cask_apps.txt ]; then
   while read F  ; do
	brew cask install --appdir="/Applications" $F
   done < ./cask_apps.txt
else
    echo "File not found"

fi

# installing node global modules if available
if [  -f ./node_packages.txt ]; then
   while read F  ; do
        npm install $F -g
   done < ./node_packages.txt
else
    echo "File not found"

fi

# installing bower
npm install -g bower

# moving chrome to applications
sudo mv /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app /Applications/

# install pip dependencies
pip install -r pip_backup.txt

# install git-flow
brew install git-flow

# install vim config environmet from amix
git clone git://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

mkdir ~/.vim
mkdir ~/.vim/colors

# move vim config file
cp ./vim/my_configs.vim ~/.vim_runtime/

# move colors
cp -r ./vim/colors/* ~/.vim/colors/
