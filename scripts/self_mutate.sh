#!/usr/bin/env bash

set +e
set -u

TERRAFORM_FOLDER=$1

cd $CODEBUILD_SRC_DIR/${TERRAFORM_FOLDER}

terraform init
terraform plan -out tfplan -detailed-exitcode
exitcode=$?
if [ $exitcode -eq 0 ]; then
    echo "No changes, not applying"
elif [ $exitcode -eq 1 ]; then
    echo "Terraform plan failed"
    exit 1
elif [ $exitcode -eq 2 ]; then
    echo "Changes found. Terraform Apply/Destroy will be initated.."
    terraform apply -auto-approve "tfplan"
    aws codepipeline start-pipeline-execution --name ${CODEBUILD_INITIATOR/codepipeline\//}
fi