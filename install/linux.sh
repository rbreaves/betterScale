#!/usr/bin/env bash

# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/rbreaves/betterScale/master/install/linux.sh)"

wget https://github.com/rbreaves/betterScale/archive/refs/heads/master.zip -O ~/Downloads/betterScale.zip || curl https://github.com/rbreaves/betterScale/archive/refs/heads/master.zip -J -L -o ~/Downloads/betterScale.zip
unzip ~/Downloads/betterScale.zip -d ~/Downloads/
cd ~/Downloads/betterScale-master/

betterScalerelease=`wget -qO- https://api.github.com/repos/rbreaves/betterScale/releases/latest | awk -F'tag_name": ' '{if ($2) print $2}' | tr -d \", || curl -s https://api.github.com/repos/rbreaves/betterScale/releases/latest | awk -F'tag_name": ' '{if ($2) print $2}' | tr -d \",`
betterScalehash=`unzip -z ~/Downloads/betterScale.zip | tail -n1`
betterScaleshort=${betterScalehash::7}

echo "$betterScalerelease" "build" "$betterScaleshort" > ./dl_version

if [ $# -eq 0 ];then
	echo "Installing betterScale..."
	./setup.sh
elif [ $1 == "-r" ];then
	echo "Uninstall betterScale..."
	# ./setup.sh -r
fi