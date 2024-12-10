#!/bin/zsh

user_name=$(whoami)

#xcode command line
xcode-select --install

#homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$user_name/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

if ! command -v brew &> /dev/null
then
    echo "brewのインストールに失敗したか、パスが通っていません"
    exit 1
fi

#ansible
brew install ansible

#execute playbook
cd ansible
cp inventory.ini.example inventory.ini
user_name=$(whoami)
sed -i "" "s/your_mac_user_name/$user_name/g" "inventory.ini"
ansible-playbook playbook.yml -i inventory.ini -K $USER_NAME

#zim
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
exec zsh -l
