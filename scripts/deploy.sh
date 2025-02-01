#!/bin/bash

set -e  # Exit immediately if a command fails

# Load environment variables from .env.local if it exists
if [ -f .env.local ]; then
  export $(grep -v '^#' .env.local | xargs)
fi

# 🔹 Google Cloud Instance Details
REMOTE_DEPLOY_SCRIPT="~/auto_deploy.sh"

echo "🚀 Starting Vue Deployment Process"

# 🛠 1. Build Vue Project Locally
echo "📦 Building Vue project..."
npm install
npm run build

# 🛠 2. Upload Built `dist/` Folder to Google Cloud Instance
echo "📡 Uploading auto_deploy script to instance..."
gcloud compute scp "./scripts/auto_deploy.sh" "$INSTANCE_NAME:~"

# 🛠 3. Upload Built `dist/` Folder to Google Cloud Instance
echo "📡 Uploading Vue build files to instance..."
gcloud compute scp --recurse "dist/" "$INSTANCE_NAME:~"

# 🛠 4. Upload production variables to Google Cloud Instance
echo "🔧 Uploading production variables..."
gcloud compute scp ".env.local" "$INSTANCE_NAME:~"

# 🛠 5. SSH into Google Cloud Instance and run automatic deployment script
echo "🔧 Running remote deployment script..."
gcloud compute ssh "$INSTANCE_NAME" --command "bash $REMOTE_DEPLOY_SCRIPT"

echo "✅ Deployment Complete! Your Vue app should be live."