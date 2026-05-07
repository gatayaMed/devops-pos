#!/bin/bash
# exit on Eroor 
set -e 

echo "Devops project Build Script " 
echo "============================="

# check if python installation

if command -v python &> /dev/null; then 
   echo "python already installed"
else 
   echo "python not found, installe it first" 

   exit 1 
fi

# Create virtual env

echo "Creating virtual env ..."


cd ../app
python3 -m venv venv
source venv/bin/activate


# Install dependencies 

echo "Installing dependencies ..."

pip install --upgrade pip 
pip install -r requirements.txt


# run tests to check 

echo "Running tests ..."
python -c "import flask; print('Flask version:', flask__version__)"

echo "Build Complete ! run 'python app.py' to start  "


