#!/bin/zsh

xcode-select --install

#homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#ansible
brew install ansible

cd ansible
cp inventory.ini.example inventory.ini
user_name=$(whoami)
sed -i "" "s/your_mac_user_name/$user_name/g" "inventory.ini"
ansible-playbook playbook.yml -i inventory.ini -K $USER_NAME

#zim
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
exec zsh -l
