terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.26.0"
      version = "~> 0.26.0"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
  token    = var.tfc_token #if the tfe runs localy, can be replaced with ENV var.
}

# Creates an organization in TFC
resource "tfe_organization" "batel-org" {
  name  = var.organization_name
  email = var.organization_email
}

# Connects between the organization and a VCS provider
resource "tfe_oauth_client" "github-vsc" {
  organization     = tfe_organization.batel-org.id
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = "${var.oauth_token}"
  service_provider = "github"
}

# Publish a module to the TFC private registry
resource "tfe_registry_module" "registry-modules" {
  vcs_repo {
    display_identifier = "${var.repository_name}"
    identifier         = "${var.repository_name}"
    oauth_token_id     = tfe_oauth_client.github-vsc.oauth_token_id
  }
}

# Creates a new Workspace on TFC (source workspace)
resource "tfe_workspace" "source-workspace" {
  name                      = var.workspaces[0]
  organization              = tfe_organization.batel-org.name
  auto_apply                = true
  execution_mode            = "remote"
  working_directory         = var.working_dir[0]
  vcs_repo {
    identifier              = "${var.repository_name}" 
    oauth_token_id          = tfe_oauth_client.github-vsc.oauth_token_id
  }
  remote_state_consumer_ids = [tfe_workspace.trrigered-workspace.id]
  allow_destroy_plan = true
}

# Creates a new Workspace on TFC (trrigered workspace)
resource "tfe_workspace" "trrigered-workspace" {
  name               = var.workspaces[1]
  organization       = tfe_organization.batel-org.name
  auto_apply         = true
  execution_mode     = "remote"
  working_directory  = var.working_dir[1]
  vcs_repo {
    identifier       = "${var.repository_name}"
    oauth_token_id   = tfe_oauth_client.github-vsc.oauth_token_id
  }
  allow_destroy_plan = true
}

# Define environment variables for the AWS credentials on both workspaces
resource "tfe_variable" "aws_id" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.AWS_ACCESS_KEY_ID
  category     = "env"
  workspace_id = tfe_workspace.source-workspace.id 
  description  = "the aws access key id"
  sensitive    = true
}

resource "tfe_variable" "aws_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.AWS_SECRET_ACCESS_KEY
  category     = "env"
  workspace_id = tfe_workspace.source-workspace.id
  description  = "the aws secret access key id"
  sensitive    = true
}

resource "tfe_variable" "aws_id2" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.AWS_ACCESS_KEY_ID
  category     = "env"
  workspace_id = tfe_workspace.trrigered-workspace.id 
  description  = "the aws access key id"
  sensitive    = true
}

resource "tfe_variable" "aws_key2" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = var.AWS_SECRET_ACCESS_KEY
  category     = "env"
  workspace_id = tfe_workspace.trrigered-workspace.id
  description  = "the aws secret access key id"
  sensitive    = true
}

# # Sends notifications regarding actions on Network workspace to slack webhook
# resource "tfe_notification_configuration" "source-ws-slack" {
#   name             = "Batel-Network-TFC"
#   enabled          = true
#   destination_type = "slack"
#   triggers         = ["run:completed"]
#   url              = ""
#   workspace_id     = tfe_workspace.source-workspace.id
# }

# # Sends notifications regarding actions on Servers workspace to slack webhook
# resource "tfe_notification_configuration" "trrigered-ws-slack" {
#   name             = "Batel-Servers-TFC"
#   enabled          = true
#   destination_type = "slack"
#   triggers         = ["run:completed"]
#   url              = "https://hooks.slack.com/services/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"
#   workspace_id     = tfe_workspace.trrigered-workspace.id
# }

# Creates a run trigger - execute the Servers workspace automaticaly after apply in the Network workspace
resource "tfe_run_trigger" "source-to-trrigered" {
  workspace_id    = tfe_workspace.trrigered-workspace.id
  sourceable_id   = tfe_workspace.source-workspace.id 
}
