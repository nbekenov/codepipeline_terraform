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
| [aws_codepipeline.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS Key ARN used to encrypt the artifacts in S3. If no value is provided, the organization default key will be used. | `string` | `null` | no |
| <a name="input_pipeline_execution_role_arn"></a> [pipeline\_execution\_role\_arn](#input\_pipeline\_execution\_role\_arn) | IAM role for pipeline | `string` | n/a | yes |
| <a name="input_pipeline_name"></a> [pipeline\_name](#input\_pipeline\_name) | Name of the pipeline. | `string` | n/a | yes |
| <a name="input_s3_artifact_bucket_name"></a> [s3\_artifact\_bucket\_name](#input\_s3\_artifact\_bucket\_name) | Name of the S3 bucket where artifacts will be stored. | `string` | n/a | yes |
| <a name="input_stages"></a> [stages](#input\_stages) | Array of 2 or more pipeline stage blocks.  A stage block contains a 'name' and action block(s).  See [Resource: aws\_codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) for documentation about stages and actions. | <pre>list(object({<br>    name = string,<br>    actions = list(object({<br>      name             = string<br>      category         = string<br>      owner            = string<br>      provider         = string<br>      version          = string<br>      run_order        = number<br>      role_arn         = string<br>      input_artifacts  = list(string)<br>      output_artifacts = list(string)<br>      configuration    = map(string)<br>      region           = string<br>      namespace        = string<br>    }))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pipeline"></a> [pipeline](#output\_pipeline) | CodePipeline terraform resource. |
<!-- END_TF_DOCS -->