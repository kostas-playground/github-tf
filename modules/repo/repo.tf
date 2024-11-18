terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}


resource "github_repository" "repo" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage_url

  visibility             = "public"
  has_issues             = true
  has_discussions        = var.has_discussions
  has_projects           = var.has_projects
  has_wiki               = false
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_rebase_merge     = true
  allow_auto_merge       = false
  delete_branch_on_merge = true
  auto_init              = false
  is_template            = var.is_template
  archived               = var.archived

  dynamic "template" {
    for_each = var.template != null ? [1] : []
    content {
      owner                = "EXUS"
      repository           = var.template
      include_all_branches = false
    }
  }

  lifecycle {
    ignore_changes = [
      topics
    ]
  }
}

# Repo Rules
resource "github_repository_ruleset" "repo" {
  name        = var.name
  repository  = github_repository.repo.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    creation                = true
    update                  = true
    deletion                = true
    required_linear_history = true
    required_signatures     = true
    non_fast_forward        = true

    pull_request {
      require_code_owner_review       = true
      required_approving_review_count = 1
    }
  }

}

# Branch Protection
resource "github_branch_protection" "branch_protection_main" {
  repository_id = github_repository.repo.name

  for_each = var.branch_policy == "main" ? toset(["master", "dev"]) : toset([])
  pattern  = each.value

  enforce_admins                  = false
  require_signed_commits          = false
  required_linear_history         = true
  require_conversation_resolution = true
  allows_deletions                = false
  allows_force_pushes             = false

  required_status_checks {
    strict = false
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    restrict_dismissals             = false
    require_code_owner_reviews      = false
    required_approving_review_count = 1
    require_last_push_approval      = true
  }
}

resource "github_branch_protection" "branch_protection_main_signed" {
  repository_id = github_repository.repo.name

  for_each = var.branch_policy == "main-signed" ? toset(["master", "dev"]) : toset([])
  pattern  = each.value

  enforce_admins                  = false
  require_signed_commits          = true
  required_linear_history         = true
  require_conversation_resolution = true
  allows_deletions                = false
  allows_force_pushes             = false

  required_status_checks {
    strict = false
  }

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    restrict_dismissals        = false
    require_last_push_approval = true
  }
}

resource "github_branch_protection" "branch_protection_infra" {
  repository_id = github_repository.repo.name

  for_each = var.branch_policy == "infra" ? toset(["master"]) : toset([])
  pattern  = each.value

  enforce_admins                  = false
  require_signed_commits          = true
  required_linear_history         = true
  require_conversation_resolution = true
  allows_deletions                = false
  allows_force_pushes             = false

  required_status_checks {
    strict = false
  }

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    restrict_dismissals        = false
    require_code_owner_reviews = true
    require_last_push_approval = true
  }
}

resource "github_repository_deploy_key" "repo_deploy_key" {
  for_each = var.deploy_keys == null ? tomap({}) : { for depk in var.deploy_keys : depk.name => depk.key }

  repository = github_repository.repo.name
  title      = each.key
  key        = each.value
  read_only  = "true"
}

# Assign teams to repo
resource "github_team_repository" "team_with_pull_access" {

  for_each = toset(var.pull_access)

  team_id    = each.value
  repository = github_repository.repo.name
  permission = "pull"

}

resource "github_team_repository" "team_with_triage_access" {
  for_each = toset(var.triage_access)

  team_id    = each.value
  repository = github_repository.repo.name
  permission = "triage"
}

resource "github_team_repository" "team_with_push_access" {
  for_each = toset(var.push_access)

  team_id    = each.value
  repository = github_repository.repo.name
  permission = "push"
}

resource "github_team_repository" "team_with_maintain_access" {
  for_each = toset(var.maintain_access)

  team_id    = each.value
  repository = github_repository.repo.name
  permission = "maintain"
}

resource "github_team_repository" "team_with_admin_access" {
  for_each = toset(var.admin_access)

  team_id    = each.value
  repository = github_repository.repo.name
  permission = "admin"
}
