
resource "aws_instance" "my_instance" {
  ami               = "ami-047126e50991d067b"
  availability_zone = "ap-southeast-1a"
  instance_type     = "t2.micro"

  tags = {
    Name        = "TF_instance"
    Environment = "Prod"
  }

  # Tagging the root volume
  root_block_device {
    tags = {
      Name        = "TF_instance"
      Environment = "Prod"
    }
  }
  
  # Enable termination protection
  disable_api_termination = true
}  


# Add tags to the default network interface
resource "aws_ec2_tag" "network_interface" {
  resource_id = aws_instance.my_instance.primary_network_interface_id

  key   = "Name"
  value = "TF_instance"

  depends_on = [aws_instance.my_instance]
  
  
}

