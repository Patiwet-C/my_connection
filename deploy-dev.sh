#!/bin/bash

# Exit on any error
set -e

echo "🚀 Starting deployment process..."

# Use FVM Flutter version
export PATH="$HOME/fvm/versions/3.32.6/bin:$PATH"

# Verify Flutter version
echo "📱 Using Flutter version:"
fvm flutter --version

# clean
echo "🧹 Cleaning..."
fvm flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
fvm flutter pub get

# Generate code
echo "🔧 Generating code..."
fvm flutter packages pub run build_runner build --delete-conflicting-outputs

# Build web version
echo "🏗️ Building web version..."
fvm flutter build web --dart-define=flavor=develop

# Deploy to Firebase
echo "🚀 Deploying to Firebase..."
firebase deploy

echo "✅ Deployment completed successfully!" 