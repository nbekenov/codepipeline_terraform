#!/usr/bin/env bash

set -u # generate exception if variable is not set.

FOLDERS=$1
ENV_NAME=$2

function run_apply {
    echo "## TERRAFORM PLAN : Generate the Terraform Plan"
    terraform apply --auto-approve
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "terraform apply command failed with exit code ${exit_code}."
        exit $exit_code
    fi
    echo "terraform apply - finished successfully"
    #terraform show -json -no-color plan.out > tf_app.json
    echo "=========================================="
}

IFSsave="$IFS"
IFS=,
vars=( $FOLDERS )
IFS="$IFSsave"
for((i=0;i<${#vars[@]};i++))
do
    TERRAFORM_FOLDER=${vars[i]}
    echo "current folder $TERRAFORM_FOLDER"
    cd $CODEBUILD_SRC_DIR/${TERRAFORM_FOLDER}
    echo "Initializing terraform backend for ${ENV_NAME} environment..."
    terraform init
    terraform workspace select ${ENV_NAME} || terraform workspace new ${ENV_NAME}
    run_apply
done