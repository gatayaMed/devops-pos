#!/bin/bash

echo "🚀 Starting counter app..."

cd ../app || {
  echo "❌ app folder not found"
  exit 1
}

source venv/bin/activate || {
  echo "❌ venv not found"
  exit 1
}

python app.py &
APP_PID=$!

echo "App running with PID: $APP_PID"
echo "Access at http://localhost:5000"
echo "To stop: kill $APP_PID"