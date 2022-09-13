resource "aws_instance" "lin-EC2" {
  ami                  = var.linAMI
  instance_type        = var.instance_type
  iam_instance_profile = var.instance-profile
  subnet_id            = var.subnet_ids
  key_name             = "ec2"
  
  tags = {
    Name = "Docker-Minikube"
  }
  vpc_security_group_ids = var.inst-sg
  ebs_optimized          = var.ebs_optimized
  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.vol_size
    delete_on_termination = true
  }
  provisioner "file" {
    source      = "${path.module}/script/docker-compose.yml"
    destination = "/home/ubuntu/docker-compose.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install ca-certificates curl gnupg lsb-release -y",
      "sudo apt install docker.io -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo apt update",
      "sudo apt install docker-compose -y",
      "sudo mkdir ~/wordpress/",
      "cd ~/wordpress/",
      "sudo cp /home/ubuntu/docker-compose.yml .",
      "sudo docker-compose up -d",
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