/*
  Launch Four t2.micro instances

*/

resource aws_instance "i7"{

 count=4
 ami="ami-047126e50991d067b"
 availability_zone="ap-southeast-1a"
 instance_type="t2.micro"

}