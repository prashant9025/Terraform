/*
 1) Create ec2 instance
 2) If env is prod create eip and attach to ec2 instance
*/


variable "env"{
 type=string
}

resource aws_instance "i7"{

 ami="ami-047126e50991d067b"
 availability_zone="ap-southeast-1a"
 instance_type="t2.micro"

}

resource aws_eip "myeip1"{
 
 count= "${var.env=="prod"?1:0}"
 instance_id="${aws_instance.i7.id}"
 
}