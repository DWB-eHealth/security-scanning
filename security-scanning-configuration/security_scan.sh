#!/bin/bash
set -e

#Pull Trivy Docker Image
echo "Pulling trivy docker image"
docker pull aquasec/trivy

#Add . to the target path if there are no target paths specified
TARGET_PATHS=("$@")
if [ -z "$TARGET_PATHS" ]; then
    TARGET_PATHS=(".")
fi

#Scan for secrets in target path
for TARGET_PATH in "${TARGET_PATHS[@]}";
do
echo "Started Scanning $TARGET_PATH"
if test -f "$TARGET_PATH/trivy-secret.yaml" ;
then
docker container run -v $(pwd):/temp aquasec/trivy --exit-code 1 fs  --security-checks secret "/temp/$TARGET_PATH" --secret-config  "temp/$TARGET_PATH/trivy-secret.yaml"
else
docker container run -v $(pwd):/temp aquasec/trivy --exit-code 1 fs  --security-checks secret "/temp/$TARGET_PATH"
fi
echo "Completed Scanning $TARGET_PATH"
done


