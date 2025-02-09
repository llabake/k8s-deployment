module "vpc" {
	source  = "terraform-google-modules/network/google"
	version = "~> 10.0"

	project_id   = var.project
	network_name = var.vpc_name
	routing_mode = "GLOBAL"

	subnets = [
			{
					subnet_name           = "subnet-01"
					subnet_ip             = "10.10.10.0/24"
					subnet_region         = var.region
			},
	]

}