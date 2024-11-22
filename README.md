# EXUS GitHub Management

- [EXUS GitHub Management](#exus-github-management)
  - [What is This Repo ❓](#what-is-this-repo-)
  - [How to Use this Repository ❓](#how-to-use-this-repository-)
    - [Creating a Team 👨‍👨‍👦‍👦](#creating-a-team-)
    - [Creating a Repository 🗃️](#creating-a-repository-️)
  - [TO-DO ✅](#to-do-)
  - [Authors 📝](#authors-)

## What is This Repo ❓

This repository serves as a control plane to manage the GitHub resources of EXUS organization. This includes teams, repos, secrets etc.

## How to Use this Repository ❓

The main files you need to modify in order to manage resources are the `teams.auto.tfvars` file to manage teams, and the `repo.auto.tfvars` to manage repos.

> ⚠️ You can only create a **Pull Request** and cannot push directly to the `main` branch.

So, make sure you:

1. Clone this repo
    ```bash
    $ git clone https://github.com/exus-ltd/exus-github.git
    ```
    or
    ```bash
    $ gh repo clone exus-ltd/exus-github
    ```
2. Create a new branch
    ```bash
    $ git checkout -b my-new-repo
    ```
3. Make the changes
4. Push the new branch
    ```bash
    $ git push origin my-new-repo
    ```
5. Open a pull request by visiting this repository's GitHub page or if you are using the GitHub CLI run `gh pr create`

### Creating a Team 👨‍👨‍👦‍👦

By modifying the `teams.auto.tfvars` file you can create/delete a new team and add/remove the appropriate member(s).

```json
teams = {
  "example-team-1" : {
    name        = "example team 1"
    description = "this team is an example"
    members = [
      "member1"
    ]
  },
  "example-team-1": {
    name = "example team 2"
    description = "this team is the second example"
    members = [
      "member1",
      "member2"
    ]
  }
}
```

> 💡 Use the **GitHub Username** of the member you want to add to a team

### Creating a Repository 🗃️

By modifying the `repos.auto.tfvars` file you can create/delete a new repo and add/remove the access to appropriate team(s). Also, you can define which secret(s) a repository will have access to.


```json
repos = {
  "example-repo" : {
    name            = "example"
    description     = "An example repository"
    has_discussions = true
    has_projects    = true
    branch_policy   = "main"
    pull_access = ["example-team-1"]
    triage_access = []
    push_access = []
    maintain_access = []
    admin_access = ["example-team-2"]
    secrets_access = ["EXAMPLE_SECRET"]
  }
}
```

## TO-DO ✅
- [] Add option to create/manage secrets 
- [] Explain the options when creating a repo

## Authors 📝
[Kostas Chikimtzis](https://github.com/kchikimtzis)

Document version 1.0
