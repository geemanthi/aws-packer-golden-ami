build {
  name    = "ami-packer"
  sources = ["source.amazon-ebs.base-ami"]

  provisioner "ansible" {
    playbook_file   = "ansible/harden.yml"
    user            = "ec2-user"
    extra_arguments = ["--tags", "level1-server,sssd"]
  }

  post-processor "manifest" {
    output = "manifest.json"
  }
}