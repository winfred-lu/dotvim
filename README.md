Vim Envionment
=============
	Manage plugins with Vundle.

Installation
-----------

	git clone https://github.com/winfred-lu/dotvim.git ~/.vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	ln -sf ~/.vim/vimrc ~/.vimrc

### Windows

for gvim

	> cd %userprofile%
	> git clone ...
	> copy .vim\vimrc _vimrc

for neovim

	> copy .vim\vimrc AppData\Local\nvim\init.vim

Usage
-----------

	vim -E -s -u ~/.vimrc +PluginInstall +qall

Note. .vimrc would be the path to rc file accordinly

