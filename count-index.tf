/*

1) Create number of Instance & volumes based on user input
2) Attach that volume to instance

*/

/*
variable "cn" {
  type = number
}

resource "aws_instance" "i1" {
  count           = var.cn
  instance_type   = "t2.micro"
  ami             = "ami-047126e50991d067b"
  availability_zone = "ap-southeast-1a"
  
  tags={
   Name="TF_Server"
  }
}

resource "aws_ebs_volume" "v1" {
  count             = var.cn
  availability_zone = "ap-southeast-1a"
  size              = 10
  type              = "gp2"
  tags={
   Name="TF_vol"
  }
}

resource "aws_volume_attachment" "v1i1" {
  count       = var.cn
  instance_id = aws_instance.i1[count.index].id
  volume_id   = aws_ebs_volume.v1[count.index].id
  device_name = "/dev/sdf"
}

*/