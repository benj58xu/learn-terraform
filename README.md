# Creating Infrastructure with Terraform

## For Developers

* Clone this repository
* Create or modify terraform in your directory `applications/`*application-name*`/`*stack_name*
* Modify 3 places in `terraform.tf`: 2 places for the above directory, and one place for AWS account number
* Create a pull request
* Wait for a minute and look for an automatically generated comment in the pull request that contains the output of `terraform plan`, and verify the planned changes.
* Request reviewing and merging the pull request 

## For Infrastructure Team

### Tag a Version of the Current Version

```
    git checkout main
    git tag v1.2.0 -m "Create application/stack org structure"
    git push origin --tags
    git checkout develop
```

