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
    source      = "${path.module}/script/dockerfile"
    destination = "/home/ubuntu/dockerfile"
  }

  provisioner "file" {
    source      = "${path.module}/script/index.html"
    destination = "/home/ubuntu/index.html"
  }

  provisioner "file" {
    source      = "${path.module}/script/deployment.yaml"
    destination = "/home/ubuntu/deployment.yaml"
  }

  provisioner "file" {
    source      = "${path.module}/script/config.json"
    destination = "/home/ubuntu/config.json"
  }



  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install ca-certificates curl gnupg lsb-release -y",
      "sudo apt install gnupg2 pass -y",
      "sudo apt install docker.io -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo apt update",
      "sudo apt install docker-compose -y",
      "sudo mkdir ~/wordpress/",
      "cd ~/wordpress/",
      "sudo cp /home/ubuntu/dockerfile .",
      "sudo cp /home/ubuntu/deployment.yaml .",
      "sudo cp /home/ubuntu/index.html .",
      "cd ..",
      ### Minikube Installation ###
      "sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
      "sudo chmod +x minikube",
      "sudo mv minikube /usr/local/bin/",
      "sudo apt install conntrack",
      "sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl",
      "sudo chmod +x ./kubectl",
      "sudo mv ./kubectl /usr/local/bin/kubectl",
      "sudo wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.2.0/cri-dockerd-v0.2.0-linux-amd64.tar.gz",
      "sudo tar xvf cri-dockerd-v0.2.0-linux-amd64.tar.gz",
      "sudo mv ./cri-dockerd /usr/local/bin/",
      "sudo wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service",
      "sudo wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket",
      "sudo mv cri-docker.socket cri-docker.service /etc/systemd/system/",
      "sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable cri-docker.service",
      "sudo systemctl enable --now cri-docker.socket",
      "sudo wget https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.25.0/crictl-v1.25.0-linux-amd64.tar.gz",
      "sudo tar zxvf crictl-v1.25.0-linux-amd64.tar.gz -C /usr/local/bin",
      "sudo rm -f crictl-v1.25.0-linux-amd64.tar.gz",
      ### Start Minikube ### 
      "sudo minikube start --vm-driver=none",
      "cd ~/wordpress/",
      #"sudo docker build -t mynginx .",
      "sudo cp /home/ubuntu/config.json /root/.docker/config.json",
      "docker login -u='jonty1247' -p='Jonty@100'",
      "sudo kubectl apply -f deployment.yaml"
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
