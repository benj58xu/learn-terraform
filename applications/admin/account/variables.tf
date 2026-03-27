variable "account_name" {
  description = "The name of the AWS account to create"
  type        = string
}

variable "account_email" {
  description = "The email address for the AWS account"
  type        = string
}

variable "organizational_unit" {
  description = "The parent organizational unit ID to place the account in"
  type        = string
}