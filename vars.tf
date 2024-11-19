variable "teams" {
  type = map(object({
    name         = string
    description  = string
    members      = optional(list(string))
    repositories = optional(list(string))
  }))
}

variable "repos" {
  type = map(object({
    name            = string
    description     = optional(string)
    template        = optional(string)
    homepage_url    = optional(string)
    has_discussions = optional(bool)
    has_projects    = optional(bool)
    is_template     = optional(bool)
    archived        = optional(bool)
    branch_policy   = optional(string)
    deploy_keys     = optional(list(object({
      name = string
      key  = string
    })))
    pull_access = optional(list(string))
    triage_access = optional(list(string))
    push_access = optional(list(string))
    maintain_access = optional(list(string))
    admin_access = optional(list(string))
  }))
}

variable "owners" {
  type = list(string)
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}
