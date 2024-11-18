terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

resource "github_team" "team" {
  name           = var.name
  description    = var.description
  privacy        = "closed"
}

resource "github_team_members" "member" {
  count = length(var.members) > 0 ? 1 : 0

  team_id = github_team.team.id

  dynamic "members" {
    for_each = toset(var.members)
    content {
      username = members.value
      role     = contains(var.owners, members.value) ? "maintainer" : "member"
    }
  }
}
