#!/usr/bin/env bash
# Check for katana updates and then run Katana

function failure
{
	echo "[!] error: $*"
	exit 1
}

function update
{
	echo "[+] installing upgrades"

	# Grab new changes
	git pull || failure "git pull failed"

	# Run pip installer just in case
	pip3 install -r requirements.txt || failure "pip install failed"
}

# Ensure we are in the repo
cd /app

# Check for updates to current branch
echo "[+] checking for updates"

git remote update >/dev/null
if git status -uno | grep "branch is up to date with" >/dev/null; then
	echo "[+] DobrevStats is up to date!"
else
	echo "[*] newer DobrevStats version avaiable (you should rebuild your docker)"
	update
fi

cd /app/bots
python3 -u main.py