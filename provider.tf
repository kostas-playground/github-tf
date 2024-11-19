terraform {
  backend "http" {
    // Best to define as environment variable $ export TF_HTTP_USERNAME=1i3slm9z
    username = var.username
    // Best to define as environment variable $ export TF_HTTP_PASSWORD=3fFWcRQbm0c5
    password = var.password
    address = "https://terraform.assignments.pkoutsias.com/client/devops/devops-exus-github/default/state"
    lock_address = "https://terraform.assignments.pkoutsias.com/client/devops/devops-exus-github/default/lock"
    unlock_address = "https://terraform.assignments.pkoutsias.com/client/devops/devops-exus-github/default/unlock"
    lock_method = "POST"
    unlock_method = "POST"
  }
  required_version = "1.8.5"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
      configuration_aliases = [github]
    }
  }
}

provider "github" {
  alias = "github"
  owner = "kostas-playground"
}
