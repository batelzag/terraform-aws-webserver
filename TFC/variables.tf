# The tfc token string
variable "tfc_token" {
    default = ""
}

# The organization name and email to create
variable "organization_name" {
    default = "Batel-OpsSchool1"
}

variable "organization_email" {
    default = "batelzag@gmail.com"
}

# The module repository name on github
variable "repository_name" {
    default = "batelzag/terraform-aws-webserver"
}

# The names of workspaces to create
variable "workspaces" {
    type = list
    description = "list of workspaces to create, start with the source one"
    default = ["Network", "Servers"]
}

# The path of working directory for workspaces
variable "working_dir" {
    type = list
    description = "list of the path of the working directory for workspaces"
    default = ["/setups/vpc", "/setups/instances"]
}

# The oauth token to github account
variable "oauth_token" {
    default = ""
}

# The aws account Credentials 
variable "AWS_ACCESS_KEY_ID" {
    default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
    default = ""
}
