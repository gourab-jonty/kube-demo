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
      "sudo yum update -y",
      "sudo yum install git -y",
      "sudo yum install httpd -y",
      "sudo yum install java -y",
      "sudo yum install java-devel -y",
      "export JAVA_HOME=(/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-2.el8_5.x86_64/jre)",
      "mkdir ~/jenkins",
      "sudo yum install openssh-server -y",
      "sudo service httpd start",
      "sudo service httpd status"
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
