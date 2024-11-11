
/*
variable "azs"{

 type=list
 default=["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
}

resource aws_ebs_volume "v2"{
 count= length(var.azs)
 size=10
 availability_zone=var.azs[count.index]
 type="gp2"

}
*/