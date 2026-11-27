build {
  name    = "ami-packer"
  sources = ["source.amazon-ebs.base-ami"]

  provisioner "ansible" {
    playbook_file   = "ansible/harden.yml"
    user            = "ec2-user"
  }

  post-processor "manifest" {
    output = "manifest.json"
  }
}