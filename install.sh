#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#dir for lib install
INSTALL=$HOME/opt
echo "add $INSTALL/bin to .bash_profile"

function log(){
   echo $1":"$2
}

#dir for tmp file
TMP=$HOME/tmp

if [[ ! -d "$TMP" ]]; then
    mkdir $TMP
fi
if [[ ! -d "$INSTALL" ]]; then
    mkdir $INSTALL
fi
####################### download software #######################
cp -r $DIR/software/* $TMP
#use the already downloaded software
#cd $TMP
#log("MSG", "begin download python")
#wget -O Python-2.7.10.tgz --no-check-certificate https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz -q
#log("MSG", "begin download vim")
#wget -O vim.tar.bz2 http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
#log("MSG", "begin download color scheme")
#wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
#log("MSG", "begin download pathogen plugin")
#curl -o ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim -k
#log("MSG", "begin download llvm clang complier for YCM")
#wget -O llvm-3.4.2.src.tar.gz http://llvm.org/releases/3.4.2/llvm-3.4.2.src.tar.gz
#log("MSG", "begin download CMake for YCM")
#wget -O cmake-3.3.1.tar.gz http://www.cmake.org/files/v3.3/cmake-3.3.1.tar.gz
#log("MSG", "begin download python_editing plugins")
#wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492

#######################   Python          ########################
cd $TMP
tar zxvf Python-2.7.10.tgz
cd Python-2.7.10
./configure --prefix=$INSTALL
make && make install
##################################################################

#######################   VIM             ########################
cd $TMP
tar jxvf vim.tar.bz2
#notice the folder name goes with the version
cd vim74
cd src
./configure --enable-pythoninterp --with-features=huge --prefix=$INSTALL
make && make install
#################################################################

########################  Color scheme  ##########################
mkdir -p ~/.vim/colors
cd $TMP
cp wombat256mod.vim ~/.vim/colors
##################################################################

#######################   Python Plugins ########################
#pathogen
#Manage your 'runtimepath' with ease.
#In practical terms, pathogen.vim makes it super easy to install plugins and runtime files in their own private directories
mkdir -p ~/.vim/autoload ~/.vim/bundle
cd $TMP
cp pathogen.vim ~/.vim/autoload

#powerline
#better-looking,more functional vim statuslines
cd ~/.vim/bundle
git clone git://github.com/Lokaltog/vim-powerline.git

#ctrlp
#Fuzzy file, buffer, mru, tag, etc finder
cd ~/.vim/bundle
git clone https://github.com/kien/ctrlp.vim.git

#Note: no longer use jedi, use YouCompleteMe(which contains jedi support for python)
#jedi-vim
#plugin jedi to vim
##cd ~/.vim/bundle
##git clone git://github.com/davidhalter/jedi-vim.git
#jedi
#awesome autocompletion/static analysis library for Python
#download jedi
##cd ~/.vim/bundle/jedi-vim
##git submodule update --init
#install jedi
##cd jedi
##python setup.py install

#YouCompleteMe
cd ~/.vim/bundle
git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
#depend on clang (a complier for c++)
cd $TMP
tar zxvf llvm-3.4.2.src.tar.gz
cd llvm-3.4.2.src
./configure --prefix=$INSTALL
make && make install
#depend on cmake
cd $TMP
tar zxf cmake-3.3.1.tar.gz
cd cmake-3.3.1
./configure --prefix=$INSTALL
make && make install
#compiling YCM
cd $TMP
mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" -DEXTERNAL_LIBCLANG_PATH=$INSTALL/lib/libclang.so . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs
echo " put .ycm_extra_conf.py file in the root dir of your project"


#python_editing
#Python folding
mkdir -p ~/.vim/ftplugin
cd $TMP
cp python_editing.vim ~/.vim/ftplugin

cp vimrc ~/.vimrc
