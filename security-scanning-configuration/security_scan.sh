#!/bin/bash
TARGET_PATHS=("$@")
if [ -z "$TARGET_PATHS" ]; then
    TARGET_PATHS=(".")
fi
for TARGET_PATH in "${TARGET_PATHS[@]}";
do
echo "Started Scanning $TARGET_PATH"
echo $TARGET_PATH
trivy --no-progress --exit-code 1 --severity HIGH,CRITICAL --auto-refresh "$TARGET_PATH"
echo "Completed Scanning $TARGET_PATH"
done