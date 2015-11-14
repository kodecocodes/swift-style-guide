#!/usr/bin/env bash

set -o pipefail

xcodebuild test -workspace <%= project_name %>.xcworkspace -scheme <%= project_name %> -sdk iphonesimulator BUILD_ACTIVE_ARCH=NO | xcpretty -t -c
