# module "webserver_VPC" {
# 	source = "app.terraform.io/Batel-OpsSchool/webserver/modules/VPC"
#   	version = "1.0.0"
# }
data "terraform_remote_state" "webserver_VPC" {
	backend = "remote"
	config = {
		organization = "Batel-OpsSchool"
		workspaces = {
      		name = "Network"
		}
    }
}
module "webserver_WEB" {
  	source  = "app.terraform.io/Batel-OpsSchool/webserver/modules/WEB" #aws
  	version = "1.0.0"
  	vpc_id = data.terraform_remote_state.webserver_VPC.outputs.vpc_id
	public_subnets = "${data.terraform_remote_state.webserver_VPC.outputs.public_subnets[*]}"
}
module "webserver_DB" {
  	source  = "app.terraform.io/Batel-OpsSchool/webserver/aws/modules/DB"
  	version = "1.0.0"	
	vpc_id = data.terraform_remote_state.webserver_VPC.outputs.vpc_id
	vpc_cidr = data.terraform_remote_state.webserver_VPC.outputs.vpc_cidr
	private_subnets = "${data.terraform_remote_state.webserver_VPC.outputs.private_subnets[*]}"
}