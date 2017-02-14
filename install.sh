#!/bin/sh

DOTDIR=$HOME/.dotfiles

echo "Linking .symlink files to ${HOME}..."
echo "=============================="

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

echo "Installing zgen..."
echo "=============================="
if [ ! -d $HOME/.zgen ]; then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
else
    echo "${HOME}/.zgen exists. Ignoring."
fi


