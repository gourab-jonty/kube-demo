resource "aws_instance" "lin-EC2" {
  count                = var.instance_count
  ami                  = var.linAMI
  instance_type        = var.instance_type
  iam_instance_profile = var.instance-profile
  subnet_id            = element(var.subnet_ids, count.index)
  key_name             = "ec2"
  tags = {
    Name = "Demo-Instance-${count.index + 1}"
  }
  vpc_security_group_ids = var.inst-sg
  ebs_optimized          = var.ebs_optimized
  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.vol_size
    delete_on_termination = true
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update-y",
      "sudo apt-get install ca-certificates curl gnupg lsb-release",
      "sudo mkdir -p /etc/apt/keyrings",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
      "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin",
      "sudo service docker start",
      "sudo docker run -p 80:80 hello-world"
    ]
  }


  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.private_ip
    private_key = file("${path.module}/key/ec2.pem")
  }

  depends_on = [var.depends]
}
