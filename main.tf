provider "aws" {

region = "ap-south-1"           
}


resource "aws_instance" "promi" {
  instance_type = "t2.medium"
 # vpc_security_group_ids = "sg-006a794d637710efc"
  associate_public_ip_address = true
  user_data = "${file("user-data.txt-1")}"
  key_name = "kk-project"
  ami = "ami-0a3277ffce9146b74"
  subnet_id = "subnet-0c37f0dbfffa82e49"
  vpc_security_group_ids = [
        aws_security_group.kk-ssh-allowed.id
        ]

  tags = {
       Name = "server-2"
 }
}

resource "aws_security_group" "kk-ssh-allowed" {
    vpc_id = "vpc-04e91fc37dc01032e"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh !
        // Do not do it in the production.
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }
    //If you do not add this rule, you can not reach the NGIX
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
