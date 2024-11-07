/*
 1) If env is dev launch t2.micro else launch t2.small
*/

/*
variable "env"{
 type = string
}

resource aws_instance "i5"{
 ami="ami-047126e50991d067b"
 instance_type="${var.env=="dev"?"t2.micro":"t2.small"}"
 
 tags={
  Name="TF_Server"
 }
}
*/

/*
output "itty"{
 value= "${var.env=="dev"?"t2.micro":"t2.small"}"
}
*/