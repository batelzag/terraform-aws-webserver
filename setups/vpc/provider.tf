# Sets AWS provider configuration
provider "aws" {
	region  = "us-east-1"
	default_tags {
		tags = {
			Enviroment 	= var.environment_tag
			Owner 		= var.owner_tag
			Project 	= var.project_tag
		}
	}
}

# Sets reomte state on TFC
terraform {
  	backend "remote" {
		hostname 		= "app.terraform.io"
		organization 	= "Batel-OpsSchool1"
		workspace {
			name = "Servers"
		}
	}
    	required_version = ">= 0.12"
	required_providers {
    		aws = {
      			source  = "hashicorp/aws"
      			version = "3.65"
		}
	}
}