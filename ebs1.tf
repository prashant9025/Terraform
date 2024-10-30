/*
resource aws_ebs_volume "vol1"{
 availability_zone="ap-southeast-1a"
 size=10
 type="gp2"
 
 tags={
  Name="TF_vol"
 }
 
}
resource aws_ebs_volume "vol2"{
 availability_zone="ap-southeast-1b"
 size=15
 type="gp3"
 
 tags={
  Name="TF_vol"
 }
 
}

output "vol1id"{
 value=aws_ebs_volume.vol1.id
}

output "vol2id"{
 value=aws_ebs_volume.vol2.id
}

*/