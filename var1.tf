/*
variable "instype"{
 type=string
}

resource aws_instance "i1"{
 ami="ami-047126e50991d067b"
 availability_zone="ap-southeast-1a"
 instance_type="${var.instype}"
 
 tags={
  Name="TF-Server"
 }
}
*/