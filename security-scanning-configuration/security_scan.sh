#!/bin/bash
set -e

#Install Trivy
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy

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
trivy --exit-code 1 fs --security-checks secret "$TARGET_PATH" --secret-config  "$TARGET_PATH/trivy-secret.yaml"
else
trivy --exit-code 1 fs --security-checks secret "$TARGET_PATH"
fi
echo "Completed Scanning $TARGET_PATH"
done