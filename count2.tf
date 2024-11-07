

resource aws_ebs_volume "vol1"{
 
 count=3
 size=8
 availability_zone="ap-southeast-1a"
 type="gp2"
 
}

output "vlid"{

 value= "${aws_ebs_volume.vol1.*.id}"
}
output "vlid1"{

 value= "${aws_ebs_volume.vol1.*.id[0]}"
}
