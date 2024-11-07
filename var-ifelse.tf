/*
 1) If env is dev launch t2.micro 
 2) else env is test t2.small
 3) else t2.large

*/

variable "env"{
 type = string
}

resource aws_instance "i5"{
 ami="ami-047126e50991d067b"
 instance_type="${var.env=="dev"?"t2.micro":var.env=="test"?"t2.small":"t2.large"}"
 
 tags={
  Name="TF_Server"
 }
}

/*
var.env=="dev"?"t2.micro":var.env=="test"?"t2.small":"t2.large"
*/

