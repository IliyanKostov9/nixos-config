#!/usr/bin/env bash

python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip
pip install pip-tools

echo "typing" > requirements.in
pip-compile --output-file=requirements.txt requirements.in
pip install -r requirements.txt

echo "Python setup completed!"
