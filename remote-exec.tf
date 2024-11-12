/*

resource aws_key_pair "abckey"{

 public_key=file("./prashant.pub")
 key_name="prashant"

}

resource aws_instance "i1"{

 ami="ami-047126e50991d067b"
 instance_type="t2.micro"
 availability_zone="ap-southeast-1a"
 key_name= aws_key_pair.abckey.key_name
 vpc_security_group_ids=["sg-0fd77880579eb7bc1"]
 tags={
  Name="TF_Server"
  Env="Test"
 }

 provisioner "remote-exec" {
  inline = [
      "cp /etc/passwd /home/ubuntu",
      "sudo useradd -m prashant",
	  "sudo apt-get update",
	  "sudo apt-get install -y apache2"
    ]

  connection {
    type     = "ssh"
    user     = "ubuntu"
	private_key= file("./prashant.pem")
    host        = self.public_ip
  }
}
 provisioner "local-exec" {
    command = "echo ${self.public_ip} >> myinv.txt"
  }

}

*/