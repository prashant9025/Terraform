/*
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
  availability_zones = ["ap-southeast-1a","ap-southeast-1b"]
  security_groups    = [aws_security_group.elb_sg.id]
  

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

  instances = [aws_instance.i1.id]
  
  tags={
   Name="TF_ELB"
  }
}

*/