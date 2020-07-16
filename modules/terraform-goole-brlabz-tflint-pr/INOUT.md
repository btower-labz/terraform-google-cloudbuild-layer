# Terraform inputs and outputs.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| google-beta | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| comment\_control | Comment control option | `string` | `""` | no |
| description | Build tribber name | `string` | `""` | no |
| ignored\_files | Files to ignore on PR update | `list` | <pre>[<br>  "**/*.md",<br>  "**/LICENSE"<br>]</pre> | no |
| name | Build tribber name | `string` | `""` | no |
| project | Target project | `string` | n/a | yes |
| repo\_branch | PR target branch | `string` | `"master"` | no |
| repo\_name | GitHUB repositoryname | `string` | n/a | yes |
| repo\_owner | GitHUB repository owner | `string` | n/a | yes |
| terraform\_version | Version of terraform for linting | `string` | `"0.12.28"` | no |

## Outputs

| Name | Description |
|------|-------------|
| description | Trigger description |
| id | Trigger id (long) |
| name | Trigger name |
| trigger\_id | Trigger id (short) |

