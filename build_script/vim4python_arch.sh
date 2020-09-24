#!/bin/bash
# sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common
sudo pacman -R vim vim-runtime
# sudo apt-get install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev
sudo pacman -Sy lua51 luajit python3 ruby perl ncurses atk libx11 libxpm libxt
git clone https://github.com/vim/vim.git
cd vim
git pull && git fetch
#In case Vim was already installed
cd src
make distclean
cd ..
./configure \
--enable-multibyte \
--enable-perlinterp=dynamic \
--enable-python3interp \
--with-python3-command=python3.8 \
--with-python3-config-dir=/usr/lib/python3.8/config-3.8m-x86_64-linux-gnu/ \
--enable-luainterp \
--with-luajit \
--enable-cscope \
--enable-gui=auto \
--with-features=huge \
--with-x \
--enable-fontset \
--enable-largefile \
--disable-netbeans \
--with-compiledby="mih" \
--enable-fail-if-missing
make && sudo make install

