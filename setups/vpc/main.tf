module "webserver_VPC" {
	source = "app.terraform.io/Batel-OpsSchool/webserver/aws//modules/VPC"
  	version = "1.0.0"
}
# module "test_WEB" {
#   	source  = "app.terraform.io/Batel-OpsSchool/webserver/modules/WEB"
#   	version = "1.0.0"
#   	vpc_id = data.terraform_remote_state.webserver_VPC.vpc_id
# 	public_subnets = "${data.terraform_remote_state.webserver_VPC.public_subnets[*]}"
# }
# module "test_DB" {
#   	source  = "app.terraform.io/Batel-OpsSchool/webserver/modules/DB"
#   	version = "1.0.0"	
# 	vpc_id = data.terraform_remote_state.webserver_VPC.vpc_id
# 	vpc_cidr = data.terraform_remote_state.webserver_VPC.vpc_cidr
# 	private_subnets = "${data.terraform_remote_state.webserver_VPC.private_subnets[*]}"
# }