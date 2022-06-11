# bash_custom

Compatible with :

- Windows Git-Bash
- Linux
- Mac OS

Use this to customize your bash profile. This will add :

- set colorfull shell
- a set of shell alias
- ssh config
- git config
- git alias

You can also add environment specific variables in $HOME/.bash_custom/.bashrc_vars

## Setup

```bash
curl https://raw.githubusercontent.com/newlight77/bash_custom/master/customize.sh | bash
```

## VIM

```bash
brew remove vim
brew cleanup
brew install vim
brew install fzf
brew install cmake
```

create folders:

```bash
mkdir -p ~/.vim/autoload ~/.vim/backup ~/.vim/colors ~/.vim/plugged
```

```tree
.vim/
 ├── autoload/
 ├── backup/
 ├── colors/
 └── plugged/

```

### vim-autoload

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

```

### vim-runtime

```bash
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
Installed the Ultimate Vim configuration successfully! Enjoy :-)
```

Show the content of .vimrc:

```bash
cat ~/.vimrc

" DO NOT EDIT THIS FILE
" Add your own customizations in ~/.vim_runtime/my_configs.vim

set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim
try
source ~/.vim_runtime/my_configs.vim
catch
endtry
```

Put the custom configuration in `~/.vim_runtime/my_configs.vim`

```bash
cp profile/vim/my_configs.vim ~/.vim_runtime/my_configs.vim
```

For YouCompleteMe, you need to compile the package:

```bash
brew install cmake
cd .vim/plugged/youcompleteme
python3 ./install.py 
```

### CoC

[Install CoC](https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim)
[CoC extensions](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)

for generic web-development consider `:CocInstall coc-tsserver coc-json coc-html coc-css`

for the list of extensions : `:CocList extensions`
