source "amazon-ebs" "basic-example" {
  region        = "us-east-1"
  source_ami    = "ami-0c4f7023847b90238"
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
  ami_name      = "packer_tag_example {{timestamp}}"
  tags = {
    OS_Version    = "Ubuntu"
    Release       = "Latest"
    Base_AMI_Name = "{{ .SourceAMIName }}"
    Extra         = "{{ .SourceAMITags.TagName }}"
  }
}

build {
  sources = [
    "source.amazon-ebs.basic-example"
  ]
}
