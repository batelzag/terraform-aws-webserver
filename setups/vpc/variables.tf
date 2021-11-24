# The environment tag
variable "environment_tag" {
    description = "which environment is it"
    default     = "Development"
}

# The owner tag
variable "owner_tag" {
    description = "who's the owner of the project"
    default     = "opsschool"
}

# The project tag
variable "project_tag" {
    description = "what is the project about"
    default     = "Whiskey"
}