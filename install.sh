#bin/sh

echo "begin install whereismyip
"
git clone https://github.com/lzhaoyang/whereismyip.git
cd whereismyip
cp whereismyip.sh ~/.whereismyip.sh && chmod a+x ~/.whereismyip.sh
echo "alias whereismyip=~/.whereismyip.sh" >> ~/.zshrc
cd .. && rm -rf whereismyip
cd ~/ && source .zshrc

echo "install whereismyip successfully"