#!/bin/bash
# shellcheck disable=SC2164

cd /home/ubuntu

# Update system and install necessary packages
yes | sudo apt update
yes | sudo apt install python3 python3-pip python3-venv git

# Clone the repo
git clone https://github.com/rahulwagh/python-mysql-db-proj-1.git
sleep 5

cd python-mysql-db-proj-1

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies in venv
pip install -r requirements.txt

echo 'Waiting for 5 seconds before running the app.py'
sleep 5

# Run app in the background using setsid (detached from terminal)
setsid python3 app.py &

# Optional: leave venv active or deactivate
# deactivate
