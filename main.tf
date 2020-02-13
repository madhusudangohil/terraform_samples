provider "aws" {
    region = "us-west-2"
    access_key = "ASIAUMCO4RIE5IDLDXEE"
    secret_key = "TcAdaTMol5wM/SbfMyCS1qlv62eudsWekDc6yzGF"
    token = "FwoGZXIvYXdzEL3//////////wEaDKhVvBIMcsAYeWHQZCK9AS/5iGF6rQv0DPuwAniKMlAju2u/DUhqniqGftBTxobZ++I++cNVusBHFYAwUsLJAZvAjiwoO9ApIJdhUWOt0PRiaj3OITkUcP0XEP3ATdBgy3EUDAqVqei9l2QanpKCa97c2dKOWSeyo9WaMj+k3N3/xG22N2r0J103eNFO94NT2O3Trn2pFns/1hdu/NoZ0GZCc1fVN1RqCaTTfFVNHDGlAYqgFDejBJfh5YqJiwxB2e4JzcoaVhqBtL0lnyjWvZbyBTItFzLCFV2DN2dJBAh26E8zi65bFxj0d+xUztipNO8gEmK7TcOL9JZZIcckeVNi"
     
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
