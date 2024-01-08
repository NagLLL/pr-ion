source "amazon-ebs" "ubuntu" {
  ami_name      = "e2esa-aws-ubuntu"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "ami-008fe2fc65df48dac"
  ssh_username  = "ubuntu"

  tags = {
    Name        = "packer_ami"
    Environment = "Production"
    Application = "Tomcat"
    CustomTag   = "SomeValue"
  }
}

build {
  type    = "amazon-ebs"
  vpc_id  = "vpc-05ce99dfef09616a6"
  subnet_id = "subnet-066fa2fc7db12b07a"
}

provisioner "shell" {
  inline = [
    "echo Installing Tomcat",
    "sleep 30",
    "sudo apt-get update",
    "sudo apt-get upgrade -y",
    "sudo apt-get install libtomcat9-java -y",
    "sudo apt-get update",
    "sudo apt-get install tomcat9-admin tomcat9-common -y",
    "sudo apt-get install tomcat9 -y",
    "cd /var/lib/tomcat9/webapps/",
    "sudo wget https://8jan2024-bucket.s3.amazonaws.com/ion.war",
    "sudo systemctl start tomcat9"
  ]
}
