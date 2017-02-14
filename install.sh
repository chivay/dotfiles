#!/bin/sh

DOTDIR=$HOME/.dotfiles

echo "Linking .symlink files to ${HOME}..."
echo "========================================"

files=$(find -H "$DOTDIR" -name '*.symlink')
for file in $files; do
    target=$HOME/.$(basename $file '.symlink')
    if [ -e $target ]; then
        echo "${target} already exists!"
    else
        echo "Linking to $file"
        ln -s $file $target
    fi
done

echo
echo "Installing zgen..."
echo "========================================"
if [ ! -d $HOME/.zgen ]; then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
else
    echo "${HOME}/.zgen exists. Ignoring."
fi

echo
echo "Installing vimplug for Neovim..."
echo "========================================"
if [ -e $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
    echo "vim-plug already installed. Ignoring."
else
    curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -d "${HOME}/.config" ]; then
    mkdir -p $HOME/.config
fi

MANAGED_DIRECTORIES="i3 i3blocks nvim"
CONFIG_PATH=$HOME/.config

echo
echo "Installing .config links"
echo "========================================"
for dir in $MANAGED_DIRECTORIES; do
    if [ -e $CONFIG_PATH/$dir  ]; then
        echo "${CONFIG_PATH}/${dir} already exists. Ignoring..."
        continue
    fi

    ln -s $DOTDIR/$dir $CONFIG_PATH/$dir

done

# Create .vimrc symlink for easier editing
if [ ! -e $HOME/.vimrc ]; then
    ln -s $DOTDIR/nvim/init.vim $HOME/.vimrc
fi
