<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_input_artifact_name"></a> [action\_input\_artifact\_name](#input\_action\_input\_artifact\_name) | Input artifact name. A previous CodePipeline stage action must output an artifact with this name as its 'output\_artifact'. | `string` | `"SourceZip"` | no |
| <a name="input_action_output_artifact_name"></a> [action\_output\_artifact\_name](#input\_action\_output\_artifact\_name) | Output artifact name. The CodePipeline action that uses this source must use the same name in its 'input\_artifact'. | `string` | `"BuiltZip"` | no |
| <a name="input_artifacts_encryption_disabled"></a> [artifacts\_encryption\_disabled](#input\_artifacts\_encryption\_disabled) | (Optional) If set to true, output artifacts will not be encrypted. If type is set to NO\_ARTIFACTS then this value will be ignored. Defaults to `true` since it's expected that S3 default encryption is used. | `bool` | `true` | no |
| <a name="input_artifacts_location"></a> [artifacts\_location](#input\_artifacts\_location) | (Optional) Information about the build output artifact location. If type is set to CODEPIPELINE or NO\_ARTIFACTS then this value will be ignored. If type is set to S3, this is the name of the output bucket. If path is not also specified, then location can also specify the path of the output artifact in the output bucket. | `string` | `null` | no |
| <a name="input_artifacts_type"></a> [artifacts\_type](#input\_artifacts\_type) | (Required) The build output artifact's type. Valid values for this parameter are: CODEPIPELINE, NO\_ARTIFACTS or S3. | `string` | `"CODEPIPELINE"` | no |
| <a name="input_build_timeout"></a> [build\_timeout](#input\_build\_timeout) | Number of minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. The default is 60 minutes. | `string` | `60` | no |
| <a name="input_codebuild_role_arn"></a> [codebuild\_role\_arn](#input\_codebuild\_role\_arn) | CodeBuild execution IAM role Arn. | `string` | n/a | yes |
| <a name="input_environment_compute_type"></a> [environment\_compute\_type](#input\_environment\_compute\_type) | (Required) Information about the compute resources the build project will use. Available values for this parameter are: BUILD\_GENERAL1\_SMALL, BUILD\_GENERAL1\_MEDIUM or BUILD\_GENERAL1\_LARGE. BUILD\_GENERAL1\_SMALL is only valid if type is set to LINUX\_CONTAINER. | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_environment_image"></a> [environment\_image](#input\_environment\_image) | (Required) The Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0), Docker Hub images (e.g. hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR (e.g. 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest). | `string` | `"aws/codebuild/amazonlinux2-x86_64-standard:3.0"` | no |
| <a name="input_environment_image_pull_credentials_type"></a> [environment\_image\_pull\_credentials\_type](#input\_environment\_image\_pull\_credentials\_type) | (Optional) The type of credentials AWS CodeBuild uses to pull images in your build. Available values for this parameter are `CODEBUILD` or `SERVICE_ROLE`. When you use a cross-account or private registry image, you must use `SERVICE_ROLE` credentials. When you use an AWS CodeBuild curated image, you must use `CODEBUILD` credentials. Default to `CODEBUILD`. | `string` | `null` | no |
| <a name="input_environment_privileged_mode"></a> [environment\_privileged\_mode](#input\_environment\_privileged\_mode) | (Optional) If set to true, enables running the Docker daemon inside a Docker container. Defaults to false. | `bool` | `null` | no |
| <a name="input_environment_type"></a> [environment\_type](#input\_environment\_type) | (Required) The type of build environment to use for related builds. Available values are: LINUX\_CONTAINER or WINDOWS\_CONTAINER. | `string` | `"LINUX_CONTAINER"` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | (Optional) A list of environment variables to make available to builds for this build project. | `list(object({ name = string, value = string, type = string }))` | `[]` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The KMS Key ID or ARN used to automatically encrypt artifacts. Defaults to `null` since it's expected that S3 default encryption is used. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Unique name for resources. | `string` | n/a | yes |
| <a name="input_queued_timeout"></a> [queued\_timeout](#input\_queued\_timeout) | Number of minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out. The default is 480 mins. | `string` | `480` | no |
| <a name="input_source_buildspec"></a> [source\_buildspec](#input\_source\_buildspec) | (Optional) The build spec declaration to use for this build project's related builds. | `string` | `null` | no |
| <a name="input_source_location"></a> [source\_location](#input\_source\_location) | (Optional) The location of the source code from git or s3. | `string` | `null` | no |
| <a name="input_source_type"></a> [source\_type](#input\_source\_type) | (Required) The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB\_ENTERPRISE, BITBUCKET, S3 or NO\_SOURCE. | `string` | `"CODEPIPELINE"` | no |
| <a name="input_stage_name"></a> [stage\_name](#input\_stage\_name) | CodePipeline Stage name. | `string` | `"Build"` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | (Optional) Enables AWS CodeBuild to access resources in an Amazon VPC. | `list(object({ vpc_id = string, subnets = list(string), security_group_ids = list(string) }))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_project"></a> [codebuild\_project](#output\_codebuild\_project) | The CodeBuild project. |
| <a name="output_stage"></a> [stage](#output\_stage) | n/a |
<!-- END_TF_DOCS -->