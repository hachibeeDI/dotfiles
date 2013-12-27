#!/bin/sh

if [ ! -x "$(which brew)" ]; then
    # Install homebrew
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
else
    echo "Homebrew is already setuped."
    exit 1
fi;
