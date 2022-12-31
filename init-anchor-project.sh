#!/bin/bash

# Retries a command on failure.
# $1 - the max number of attempts
# $2... - the command to run

retry() {
    local -r -i max_attempts="$1"; shift
    local -i attempt_num=1
    until "$@"
    do
        if ((attempt_num==max_attempts))
        then
            echo "Attempt $attempt_num failed and there are no more attempts left!"
            return 1
        else
            echo "Attempt $attempt_num failed! Trying again in $attempt_num seconds..."
            sleep $((attempt_num++))
        fi
    done
}

VALID_ARGS=$(getopt -o n:,h --long name:,no-solana-init,no-workspace-init,help -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi

name=$(basename $(cd $(dirname "${BASH_SOURCE[0]}") && pwd))
solana_init=true
workspace_init=true
eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
    -n | --name)
        name=$2
        shift 2
        ;;
    -h | --help)
        echo 'init-anchor-project
Initialize a new anchor project.

This script will initialize a new solana wallet and airdrop 2 SOL. Afterward it
initializes an anchor project in the root directory. Once completed it creates
a script that initializes a new codespace by building the project and
installing dependencies. After executing it, this script will self-destruct.

USAGE:
    init-anchor-project [FLAGS] [OPTIONS]

FLAGS:
    -h, --help              Prints help information
    --no-solana-init        Do not initialize a new solana wallet
    --no-workspace-init     Do not initialize the workspace at the end
                            ! the init-workspace script is still created !

OPTIONS
    -n, --name              Set the anchor project name [default: '"${name}"']
'
        exit 
        ;;
    --no-solana-init)
        solana_init=false
        shift
        ;;
    --no-workspace-init)
        workspace_init=false
        shift
        ;;
    --) shift; 
        break 
        ;;
  esac
done

if [ $solana_init = true ]; then
    echo 
    echo Initialize solana wallet and airdrop 2 SOL
    echo ==========================================
    echo 
    solana-keygen new --no-bip39-passphrase
    solana config set --url https://api.devnet.solana.com
    retry 3 solana airdrop 2
fi

echo 
echo Initialize anchor project
echo =========================
echo 

anchor init $name --no-git
#move directory one up
shopt -q dotglob; dotglob_set=$?
((dotglob_set)) && shopt -s dotglob
mv $name/* .
((dotglob_set)) && shopt -u dotglob
rmdir $name
#edit gitignore to ignore .yarn folder
echo ".yarn" >> .gitignore

#Create init workspace script
echo '#!/bin/bash

echo 
echo Initialize workspace with initial builds
echo ========================================
echo 
#npm is needed for VSCode intellisense
npm i
#run yarn install afterwards links yarn and npm (npm must not be run again afterward)
yarn install
#compile anchor for first time so that the test srcipt finds idl
anchor build' > ./init-workspace.sh

chmod +x ./init-workspace.sh
git add ./init-workspace.sh

#self destruction
rm "$BASH_SOURCE"

if [ $workspace_init = true ]; then
    ./init-workspace.sh
fi