// Declare global variables
// Set the variable value in *.tfvars file
// or using -var="do_token=..." CLI option
// or set an env var with export TF_VAR_do_token="..."
variable "do_token" {
  description = "Your DigitalOcean API token."
}

variable "github_repo_name" {
  description = "Name of the target repository."
  type        = string
}

variable "github_access_token" {
  description = "Personal access token for the admin access to the repository"
  type        = string
}
