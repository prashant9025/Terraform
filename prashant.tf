/*
1) Create a VPC
2) Divide 2 Subnets for Public and Private
3) Create security Group Allow Below rules
   IB - 22 --> 67.90.90.90/32
      80 --> 0.0.0.0/0
   OB -  All Traffic
4) Luanch Ec2 instance in Public Subnet
   Install Apache2 Webserver and Attach Step 3
5) Create Classic ELB and Attach to Step 4 Instance
6) Create Launch Template and Auto Scaling Group
7) Attach ELB to AutoScaling Group
*/

/*

#To create VPC

resource aws_vpc "vpc1"{
 cidr_block = "10.0.0.0/24"
 
 tags={
  Name="TF_prashant_vpc"
 }
}

#public Subnet

resource aws_subnet "sn1"{
 vpc_id=aws_vpc.vpc1.id
 cidr_block="10.0.0.0/25"
 availability_zone="ap-southeast-1a"
 map_public_ip_on_launch = true
 tags={
  Name="TF_pub"
 }
}

#private subnet

resource aws_subnet "sn2"{
 vpc_id=aws_vpc.vpc1.id
 cidr_block="10.0.0.128/25"
 availability_zone="ap-southeast-1b"
 
 tags={
  Name="TF_pvt"
 }
}

#internet gateway

resource "aws_internet_gateway" "igw"{
 vpc_id = aws_vpc.vpc1.id
 tags = {
  Name = "TF_IGW"
 }
}

#To create route table for public 

resource "aws_route_table" "rt1"{
 vpc_id = aws_vpc.vpc1.id
 tags = {
  Name = "TF_PUB_RT"
 }
}

#To create route table for private
 
resource "aws_route_table" "rt2"{
 vpc_id = aws_vpc.vpc1.id
 tags = {
  Name = "TF_PVT_RT"
 }
}

#To attach internet gateway to vpc1

resource "aws_route" "addigw"{
 route_table_id = aws_route_table.rt1.id
 destination_cidr_block = "0.0.0.0/0"
 gateway_id = aws_internet_gateway.igw.id
}

#To attach route table to public subnet

resource "aws_route_table_association" "sn1rt1"{
 subnet_id = aws_subnet.sn1.id
 route_table_id = aws_route_table.rt1.id
}

#To attach route table to private subnet

resource "aws_route_table_association" "sn2rt2"{
 subnet_id = aws_subnet.sn2.id
 route_table_id = aws_route_table.rt2.id
}

#To create security group

resource "aws_security_group" "sg1"{
 vpc_id = aws_vpc.vpc1.id
 name        = "TFSG1"
 description = "TFSG1"
 ingress {
    description      = "Allow incoming request"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]   
  }
  ingress {
    description      = "Allow incoming request"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]   
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  tags = {
   Name = "TF_SG" 
  }

}

# To create key pair

resource "aws_key_pair" "prashant" {
  key_name   = "prashant"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAa6zWIDR89y7tUGocDDtiXfvRHRrrChvzCzgpgfWmYZ Prashant Pawar@IMSMUMDTO01101"
}

#To launch instance and install apache in it.

resource aws_instance "i1"{
 ami="ami-047126e50991d067b"
 instance_type="t2.micro"
 subnet_id=aws_subnet.sn1.id
 vpc_security_group_ids=[aws_security_group.sg1.id]
 key_name="prashant"
 user_data=file("./web.sh")
 tags={
  Name="TF_Webserver"
  Env="Prod"
 }

}
resource aws_instance "i2"{
 ami="ami-047126e50991d067b"
 instance_type="t2.micro"
 subnet_id=aws_subnet.sn1.id
 vpc_security_group_ids=[aws_security_group.sg1.id]
 key_name="prashant"
 user_data=file("./web.sh")
 tags={
  Name="TF_Webserver"
  Env="Prod"
 }

}


# create Security Group for ELB

resource aws_security_group "elb_sg"{
 vpc_id = aws_vpc.vpc1.id
 name        = "TF_LB_SG1"
 description = "TF_LB_SG1"
 
  ingress {
    description      = "Allow incoming request"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]   
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  tags = {
   Name = "TF_LB_SG" 
  }

}

# Create a Classic ELB and attach to the instance

resource aws_elb "web_elb" {
  name               = "web-elb"
  
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.sn1.id]
  

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  instances = [aws_instance.i1.id,aws_instance.i2.id]
  
  tags={
   Name="TF_ELB"
  }
}

# To create launch_template

resource "aws_launch_template" "temp" {
  
  name = "TF_template"
  
  image_id="ami-047126e50991d067b"
  instance_type="t2.micro"
  vpc_security_group_ids=[aws_security_group.sg1.id]
  key_name= "prashant"
  
  user_data=filebase64("${path.module}/web.sh")
  
  tags={
   Name="TF_ln_tmp"
  }
}

# To Create Auto Scaling Group and attach to ELB

resource aws_autoscaling_group "ASG"{
 name = "ASG_1"
 launch_template {
    id      = aws_launch_template.temp.id
    version = "$Latest"
  }
 
 vpc_zone_identifier = [aws_subnet.sn1.id]
  desired_capacity   = 1
  max_size           = 5
  min_size           = 1
  
  tag {
    key                 = "Name"
    value               = "ASG_TF"
    propagate_at_launch = true
  }

 
}

# To attach ELB to Auto scaling group

resource aws_autoscaling_attachment "elb-as"{
 
 autoscaling_group_name = aws_autoscaling_group.ASG.id
 elb = aws_elb.web_elb.id
 
}


*/
