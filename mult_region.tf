/*
 create resources in multi-region

*/

/*
resource aws_ebs_volume "v1"{
  provider=aws.mum
  availability_zone="ap-south-1a"
  size=10
  type="gp2"
  
  tags={
   Name="TF_vol"
  }
}

resource aws_ebs_volume "v2"{
  
  availability_zone="ap-southeast-1a"
  size=10
  type="gp2"
  
  tags={
   Name="TF_vol"
  }

}
*/