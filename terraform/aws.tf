provider "aws" {
  region			= var.aws_region
  shared_config_files		= ["~/.aws/conf"]
  shared_credentials_files	= ["~/.aws/credentials"]  
  profile			= "terraform-user-jblacker"
}
