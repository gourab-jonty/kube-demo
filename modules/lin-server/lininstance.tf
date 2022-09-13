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
      "sudo apt-get update",
      "sudo apt-get install ca-certificates curl gnupg lsb-release -y",
      "sudo apt install docker.io -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo apt install docker-compose -y",
      "sudo docker run -p 80:80 nginx"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.private_ip
    private_key = file("${path.module}/key/ec2.pem")
  }

  depends_on = [var.depends]
}
