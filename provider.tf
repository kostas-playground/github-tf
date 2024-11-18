terraform {
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
