module "workload-preprod-devops" {
  source = "../../../modules/aft-account-request"

  control_tower_parameters = {
    AccountName               = "workload-preprod-devops"
    AccountEmail              = "aws-workload-preprod-devops@subaru.com"
    ManagedOrganizationalUnit = "Preprod (ou-d5mz-znvs7ep3)"
    SSOUserEmail              = "admin@subaru.com"
    SSOUserFirstName          = "Platform"
    SSOUserLastName           = "Admin"
  }

  account_tags = {
    "soa:environment" = "preprod"
    "soa:cost_center" = "10.605301.0000.506.00.000.000"
  }

  change_management_parameters = {
    change_requested_by = "Samuel Sokeye"
    change_reason       = "New Preprod DevOps Account"
  }

  custom_fields = {
    application_name = "devops"
    environment      = "preprod"
    region           = "us-east-1"
    vpc_cidr         = "10.150.16.0/23"
    subnet_newbits   = "2"
    account_type     = "disconnected"
  }

  account_customizations_name = "standard_account_template"
}