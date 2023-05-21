#!/usr/bin/env bash
set -o errexit

## If Python 3.10 is not yet installed
# sudo apt update
# sudo apt install software-properties-common
# sudo add-apt-repository ppa:deadsnakes/ppa
# sudo apt update
# sudo apt install python3.10

# Check python virtual environment already exist
if [[ ! -d "python_local" ]]; then
    virtualenv python_local    
fi

source python_local/bin/activate

python -m pip install --upgrade pip

pip install -r requirements.txt

