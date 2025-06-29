#!/bin/bash

set -e

# Check if there are already staged changes before pulling
if ! git diff --cached --quiet; then
  echo "⚠️ Committing pre-staged changes before pulling..."
  git commit -m "Pre-sync commit of staged changes"
fi

echo "🔄 Pulling latest changes from Codex (rebased)..."
git pull --rebase

echo "📦 Staging all local changes..."
git add -A

if ! git diff --cached --quiet; then
  echo "📝 Committing local changes..."
  git commit -m "Auto-sync local edits"
  echo "⬆️ Pushing to GitHub..."
  git push
else
  echo "✅ No new local changes to commit."
fi
