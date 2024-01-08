source "amazon-ebs" "ubuntu" {
  ami_name      = "e2esa-aws-ubuntu"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  source_ami    = "ami-03f4878755434977f" 
  ssh_username  = "ubuntu"

  tags = {
    Name        = "packer_ami"
    Environment = "Production"
    Application = "Tomcat"
    CustomTag   = "SomeValue"
  }
}

build {
  name = "e2esa-packer1"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
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
}
