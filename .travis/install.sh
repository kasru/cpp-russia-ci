#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" == 'Darwin' ]]; then
    brew update || brew update
    brew outdated pyenv || brew upgrade pyenv
    brew install pyenv-virtualenv
    brew install cmake || true
    brew upgrade cmake || true

    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi

    pyenv install 2.7.10
    pyenv virtualenv 2.7.10 conan
    pyenv rehash
    pyenv activate conan
    
    CC="clang"
    CXX="clang++"
fi

if [[ "$(uname -s)" == 'Linux' ]]; then
    CC=$C_COMPILER
    CXX=$CXX_COMPILER
fi

if [[ "$(uname -s)" == 'Linux' ]]; then
   PIP_USER_FLAG="--user"
else
   PIP_USER_FLAG=""
fi

pip install $PIP_USER_FLAG conan
conan remote add conan.io https://server.conan.io false

conan user
