/*
resource "aws_instance" "my_instance" {
  ami               = "ami-06650ca7ed78ff6fa"
  instance_type     = "t2.micro"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name        = "TF_instance"
    Environment = "Prod"
  }

  # Enable termination protection
  disable_api_termination = true

}
*/
