/*
resource aws_instance "i23"{
 ami="ami-047126e50991d067b"
 availability_zone="ap-southeast-1a"
 instance_type="t2.micro"
 
 tags={
  Name="TF_I1"
  Env="Test"
 }
}

resource aws_instance "i2"{
 ami="ami-047126e50991d067b"
 availability_zone="ap-southeast-1b"
 instance_type="t2.small"
 
 tags={
  Name="TF_I2"
  Env="Prod"
 }
}

resource aws_eip "myeip"{
 instance=aws_instance.i2.id
 
 tags={
  Name="TF_eip"
 }

}
resource aws_eip "myeip_1"{
 instance=aws_instance.i1.id
 
 tags={
  Name="TF_eip_1"
 }

}

output "i1id"{
 value=aws_instance.i1.id
}

*/