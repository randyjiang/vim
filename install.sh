#!/bin/sh

################# HOW TO USE THIS ###########################
#### 1. modify your own library path $INSTALL and INSTALL/bin to .bash_profile
#### 2. uncomment the software you don't have yet to download (and check whether you can downlaod them )
#### 3. check whether you can use git command for github (some plugins are downloaded using git from github)



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

cp -r $DIR/software/* $TMP

#######################   Python          ########################
#cd $TMP
#tar zxvf Python-2.7.10.tgz
#cd Python-2.7.10
#./configure --prefix=$INSTALL
#make
#make install
##################################################################

#######################   VIM             ########################
#cd $TMP
#tar jxvf vim-7.4.tar.bz2
##notice the folder name goes with the version
#cd vim74
#cd src
#./configure --enable-pythoninterp --with-features=huge --prefix=$INSTALL
#make
#make install
#################################################################


##################################################################
#######################   Plugins ################################
##################################################################

########### pathogen ###########
#Manage your 'runtimepath' with ease.
#In practical terms, pathogen.vim makes it super easy to install plugins and runtime files in their own private directories
mkdir -p ~/.vim/autoload ~/.vim/bundle
cd $TMP
cp pathogen.vim ~/.vim/autoload


#############  Color scheme  ########
mkdir -p ~/.vim/colors
cd $TMP
cp wombat256mod.vim ~/.vim/colors

########### powerline ################
#better-looking,more functional vim statuslines
cd ~/.vim/bundle
git clone git://github.com/Lokaltog/vim-powerline.git

########## ctrlp  ####################
#Fuzzy file, buffer, mru, tag, etc finder
cd ~/.vim/bundle
git clone https://github.com/kien/ctrlp.vim.git

########## python_editing ##############
#Python folding
mkdir -p ~/.vim/ftplugin
cd $TMP
cp python_editing.vim ~/.vim/ftplugin

######################### YouCompleteMe #################
cd ~/.vim/bundle
git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
#depend on clang (a complier for c++)
cd $TMP
tar zxvf llvm-3.4.2.src.tar.gz
cd llvm-3.4.2.src
./configure --prefix=$INSTALL
make
make install
#depend on cmake
cd $TMP
tar zxf cmake-3.3.1.tar.gz
cd cmake-3.3.1
./configure --prefix=$INSTALL
make
make install
#compiling YCM
cd $TMP
mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" -DEXTERNAL_LIBCLANG_PATH=$INSTALL/lib/libclang.so . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs


########### cp conf #############
cp $DIR/.* ~/

echo "=======WARNING!!!============="
echo "add $INSTALL/bin to PATH in .bash_profile  "
echo "=============================="

