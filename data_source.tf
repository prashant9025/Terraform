/*
 1) want to know how many AZ available in region.
 2) and want to print AZ names.
*/


data aws_availability_zones "azs"{

}

resource aws_ebs_volume "v1"{
 
 count= length(data.aws_availability_zones.azs.names)
 size=8
 type="gp2"
 availability_zone= data.aws_availability_zones.azs.names[count.index]

 tags={
  Name= "TF_vol"
 }
}

/*
output "azsval"{

 value = data.aws_availability_zones.azs.names

}
output "noofel"{

 value = length(data.aws_availability_zones.azs.names)

}
*/