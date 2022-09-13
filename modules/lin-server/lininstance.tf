resource "aws_instance" "lin-EC2" {
  count                = var.instance_count
  ami                  = var.linAMI
  instance_type        = var.instance_type
  iam_instance_profile = var.instance-profile
  subnet_id            = element(var.subnet_ids, count.index)
  key_name             = "ec2"
  tags = {
    Name = "Docker-Minikube-${count.index + 1}"
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
      "sudo resize2fs /dev/nvme0n1p1",
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
      #"sudo docker-compose up -d",
      "sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
      "sudo install minikube-linux-amd64 /usr/local/bin/minikube",
      "sudo apt-get install conntrack",
      "minikube start --driver=none"
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
