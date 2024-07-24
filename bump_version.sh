#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {major|minor|patch|build}"
    exit 1
fi

VERSION_TYPE=$1
PUBSPEC_PATH="base_flutter/pubspec.yaml"

# Check if the git command is available
if ! command -v git &> /dev/null
then
    echo "git could not be found. Please install git and ensure it is in your PATH."
    exit 1
fi

# Check if pubspec.yaml exists
if [ ! -f $PUBSPEC_PATH ]; then
    echo "pubspec.yaml not found in the RIA directory."
    exit 1
fi

# Extract the current version
CURRENT_VERSION=$(grep '^version:' $PUBSPEC_PATH | sed 's/version: //')
IFS='+' read -r VERSION BUILD_NUMBER <<< "$CURRENT_VERSION"
IFS='.' read -r MAJOR MINOR PATCH <<< "$VERSION"

# If BUILD_NUMBER is not set, initialize it to 0
if [ -z "$BUILD_NUMBER" ]; then
    BUILD_NUMBER=0
fi


# Bump the version
case $VERSION_TYPE in
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
	BUILD_NUMBER=$((BUILD_NUMBER + 1))
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
	BUILD_NUMBER=$((BUILD_NUMBER + 1))
        ;;
    patch)
        PATCH=$((PATCH + 1))
	BUILD_NUMBER=$((BUILD_NUMBER + 1))
        ;;
    build)
        BUILD_NUMBER=$((BUILD_NUMBER + 1))
        ;;
    *)
        echo "Unknown version type: $VERSION_TYPE"
        exit 1
        ;;
esac


NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}+${BUILD_NUMBER}"

# Update the version in pubspec.yaml
sed -i '' "s/^version: .*/version: $NEW_VERSION/" $PUBSPEC_PATH

# Commit and push the changes
git add $PUBSPEC_PATH
git commit -m "Bump version to $NEW_VERSION"
git push origin $version

echo "Bumped version to $NEW_VERSION"
