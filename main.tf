module "repo" {
  source = "./modules/repo"
  providers = {
    github = github.github
  }
  for_each = var.repos

  name            = each.value.name
  description     = try(each.value.description, "")
  template        = try(each.value.template, null)
  homepage_url    = try(each.value.homepage_url, null)
  has_discussions = try(each.value.has_discussions, false)
  has_projects    = try(each.value.has_projects, false)
  is_template     = try(each.value.is_template, false)
  archived        = try(each.value.archived, false)
  branch_policy   = try(each.value.branch_policy, null)
  deploy_keys     = try(each.value.deploy_keys, [])
  pull_access     = try(each.value.pull_access, [])
  triage_access   = try(each.value.triage_access, [])
  push_access     = try(each.value.push_access, [])
  maintain_access = try(each.value.maintain_access, [])
  admin_access    = try(each.value.admin_access, [])
  secrets_access  = try(each.value.secrets_access, [])
}

module "team" {
  source = "./modules/team"
  providers = {
    github = github.github
  }

  depends_on = [
    module.repo
  ]

  for_each = var.teams

  name        = each.value.name
  description = each.value.description
  members     = try(each.value.members, [])
  owners      = var.owners
}
