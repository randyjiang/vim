#!/bin/sh

#######################   Python          ########################
#wget -O Python-2.7.10.tgz --no-check-certificate https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
#tar zxvf Python-2.7.10.tgz

##################################################################

#######################   VIM             ########################
wget -O vim.tar.bz2 http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar jxvf vim.tar.bz2
#notice the folder name goes with the version
cd vim74
cd src
./configure --enable-pythoninterp --with-features=huge --prefix=$HOME/opt/vim
make && make install
mkdir -p $HOME/bin
cd $HOME/bin
ln -s $HOME/opt/vim/bin/vim
which vim
vim --version
echo "ADD $HOME/bin to you PATH in .bash_profile"
#################################################################

########################  Color scheme  ##########################
mkdir -p ~/.vim/colors && cd ~/.vim/colors
wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
##################################################################

#######################   Python Plugins ########################
#pathogen
#Manage your 'runtimepath' with ease.
#In practical terms, pathogen.vim makes it super easy to install plugins and runtime files in their own private directories
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -o ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

#powerline
#better-looking,more functional vim statuslines
cd ~/.vim/bundle
git clone git://github.com/Lokaltog/vim-powerline.git

#ctrlp
#Fuzzy file, buffer, mru, tag, etc finder
cd ~/.vim/bundle
git clone https://github.com/kien/ctrlp.vim.git

#jedi-vim
#plugin jedi to vim
cd ~/.vim/bundle
git clone git://github.com/davidhalter/jedi-vim.git
#jedi
#awesome autocompletion/static analysis library for Python
#download jedi
cd ~/.vim/bundle/jedi-vim
git submodule update --init
#install jedi
cd jedi
python setup.py install

#python_editing
#Python folding
mkdir -p ~/.vim/ftplugin
wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492

#################################################################
