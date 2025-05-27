#!/usr/bin/env bash
# 1. The local dependency cache will be cleared.
# 2. Re-obtain dependencies from the Internet
# run command: bash shells/clean.sh
cd ..
flutter clean
# rm pubspec.lock
# rm -rf podfile.lock
# rm -rf build/
# rm -rf .android/
# rm -rf .ios/
# rm -rf .idea/
# find . -name '*.iml' -type f -delete
# rm -rf ~/.pub-cache/
flutter pub get
flutter gen-l10n --arb-dir lib/languages/res
# ios install lib
cd ios && pod cache clean --all && xcodebuild clean && rm -rf ~/Library/Developer/Xcode/DerivedData/* && pod deintegrate && pod setup && pod install