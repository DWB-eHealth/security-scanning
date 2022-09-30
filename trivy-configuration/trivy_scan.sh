#!/bin/bash
TARGET_PATHS=("$@")
if [ -z "$TARGET_PATHS" ]; then
    TARGET_PATHS=(".")
fi
for TARGET_PATH in "${TARGET_PATHS[@]}";
do
echo "Started Scanning $TARGET_PATH"
trivy fs --exit-code 1 "$TARGET_PATH"
echo "Completed Scanning $TARGET_PATH"
done