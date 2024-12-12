
resource aws_instance "i1"{
 
 ami = "ami-06650ca7ed78ff6fa"
 availability_zone = "ap-southeast-1a"
 instance_type = "t2.micro"
 
 tags={
  Name = "TF_Instance_Singa"
  
 }
}


resource aws_instance "i2"{
  
 provider = aws.mum
 ami = "ami-053b12d3152c0cc71"
 availability_zone = "ap-south-1a"
 instance_type = "t2.micro"
 
 tags={
  Name = "TF_Instance_Mum"
  
  
 }
}

