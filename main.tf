variable "awsConfig" {}

provider "aws" {
    region = "${var.awsConfig.region}"
    access_key = "${var.awsConfig.access_key}"
    secret_key = "${var.awsConfig.secret_key}"
    token = "${var.awsConfig.token}"
     
}

resource "aws_instance" "sms-tf-test" {
    ami = "ami-0302f3ec240b9d23c"
    instance_type = "t2.micro"

    user_data = <<-EOF
                #!/bin/bash
                sudo su
                yum update -y
                yum install httpd -y
                service httpd start
                chkconfig httpd on
                echo "Hello you are now terraform champ" > /var/www/html/index.html
                EOF

    tags ={
        Name = "sms-tf-test"
    }
}

resource "aws_security_group" "ec2-sms-terraform-sg" {
    name = "sms ec2 terraform sg"
    description = "allow web traffic"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
  
}
