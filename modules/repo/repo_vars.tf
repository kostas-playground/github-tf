variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = ""
}

variable "template" {
  type    = string
  default = null
}

variable "homepage_url" {
  type    = string
  default = null
}

variable "has_discussions" {
  type    = bool
  default = false
}

variable "has_projects" {
  type    = bool
  default = false
}

variable "is_template" {
  type    = bool
  default = false
}

variable "archived" {
  type    = bool
  default = false
}

variable "branch_policy" {
  type    = string
  default = "main"

  validation {
    error_message = "Invalid branch policy."
    condition     = contains(
      [
        "none",
        "main",
        "main-signed",
        "infra"
      ],
      coalesce(var.branch_policy, "none"))
  }
}

variable "deploy_keys" {
  type = list(object({
    name = string,
    key  = string
  }))
  default = []
}

variable "pull_access" {
  type = list(string)
  default = []
}

variable "triage_access" {
  type = list(string)
  default = []
}

variable "push_access" {
  type = list(string)
  default = []
}

variable "maintain_access" {
  type = list(string)
  default = []
}

variable "admin_access" {
  type = list(string)
  default = []
}

variable "secrets_access" {
  type = list(string)
  default = []
}