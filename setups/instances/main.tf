# module "webserver_vpc" {
# 	source = "app.terraform.io/Batel-OpsSchool1/webserver/aws//modules/vpc"
#   	version = "1.0.0"
# }
data "terraform_remote_state" "webserver_vpc" {
	backend = "remote"
	config = {
		organization = "Batel-OpsSchool1"
		workspaces = {
      		name = "Network"
		}
    }
}
module "webserver_web" {
  	source  = "app.terraform.io/Batel-OpsSchool1/webserver/aws//modules/web"
  	version = "1.0.0"
  	vpc_id = data.terraform_remote_state.webserver_vpc.outputs.vpc_id
	public_subnets = "${data.terraform_remote_state.webserver_vpc.outputs.public_subnets[*]}"
}
module "webserver_db" {
  	source  = "app.terraform.io/Batel-OpsSchool1/webserver/aws//modules/db"
  	version = "1.0.0"	
	vpc_id = data.terraform_remote_state.webserver_vpc.outputs.vpc_id
	vpc_cidr = data.terraform_remote_state.webserver_vpc.outputs.vpc_cidr
	private_subnets = "${data.terraform_remote_state.webserver_vpc.outputs.private_subnets[*]}"
}
