#!/bin/zsh

set -e

user_name=$(whoami)

if ! xcode-select -p >/dev/null 2>&1; then
    echo "=== Xcode Command Line Tools をインストール中 ==="
    xcode-select --install
else
    echo "Xcode Command Line Tools は既にインストールされています"
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "=== Homebrew をインストール中 ==="
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "/Users/$user_name/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew は既にインストールされています"
fi

if ! brew list ansible >/dev/null 2>&1; then
    echo "=== Ansible をインストール中 ==="
    brew install ansible
else
    echo "Ansible は既にインストールされています"
fi

if [ -d "ansible" ]; then
    echo "=== Ansible Playbook を実行中 ==="
    cd ansible
    if [ ! -f "inventory.ini" ]; then
        cp inventory.ini.example inventory.ini
        sed -i "" "s/your_mac_user_name/$user_name/g" "inventory.ini"
    fi
    ansible-playbook playbook.yml -i inventory.ini -K
else
    echo "Ansible ディレクトリが見つかりませんでした。Playbook の実行をスキップします。"
fi

if [ ! -d "$HOME/.zim" ]; then
    echo "=== Zimfw をインストール中 ==="
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
    exec zsh -l
else
    echo "Zimfw は既にインストールされています"
fi
