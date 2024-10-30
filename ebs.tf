#To create ebs volume

/*
resource aws_ebs_volume "vol1"{
  availability_zone="ap-southeast-1a"
  size="10"
  type="gp2"
  
  tags={
   Name="TF_vol_1"
  }

}

resource aws_ebs_volume "vol2"{
  availability_zone="ap-southeast-1b"
  size="15"
  type="gp3"
  
  tags={
   Name="TF_vol_2"
  }

}

*/