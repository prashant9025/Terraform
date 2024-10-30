# To create key pair(while launching attach to ec2 instance)
# and create ec2 instance

/*
resource "aws_key_pair" "prashant" {
  key_name   = "prashant"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAa6zWIDR89y7tUGocDDtiXfvRHRrrChvzCzgpgfWmYZ Prashant Pawar@IMSMUMDTO01101"
}

resource aws_instance "I1"{
  ami="ami-047126e50991d067b"
  instance_type="t2.micro"
  availability_zone="ap-southeast-1b"
  key_name="prashant"
  
  tags={
   Name="TF_instance_1"
  }
}

*/