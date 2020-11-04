resource "aws_instance" "csgo_ansible_instance" {
  ami           = "${data.aws_ami.Amazon_Linux.id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet_id     = "${aws_subnet.public_subnet_us_east_1a.id}"

root_block_device {
  volume_type = "gp2"
  volume_size = "30"
  delete_on_termination = "true"
  }

  vpc_security_group_ids = [
    "${aws_security_group.ssh.id}",
    "${aws_security_group.csgo.id}",
  ]

  tags = {
    Name       = "counter_strike_go_server"
    Automation = "true"
  }
}

resource "null_resource" "csgo_post_install" {

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /provision",
      "sudo chmod 777 /provision",
    ]

    connection {
      host        = "${aws_instance.csgo_ansible_instance.public_dns}"
      type        = "ssh"
      user        = "${var.ami_user}"
      private_key = "${file("${var.private_key}")}"
    }
  }

  provisioner "file" {
    source      = "vagrant/provision/gsm.yaml"
    destination = "/tmp/gsm.yaml"

    connection {
      host        = "${aws_instance.csgo_ansible_instance.public_dns}"
      type        = "ssh"
      user        = "${var.ami_user}"
      private_key = "${file("${var.private_key}")}"
    }
  }

  provisioner "file" {
    source      = "vagrant/provision/os_dependencies.sh"
    destination = "/tmp/os_dependencies.sh"

    connection {
      host        = "${aws_instance.csgo_ansible_instance.public_dns}"
      type        = "ssh"
      user        = "${var.ami_user}"
      private_key = "${file("${var.private_key}")}"
    }
  }

  provisioner "file" {
    source      = "vagrant/provision/csgoserver"
    destination = "/provision/csgoserver"

    connection {
      host        = "${aws_instance.csgo_ansible_instance.public_dns}"
      type        = "ssh"
      user        = "${var.ami_user}"
      private_key = "${file("${var.private_key}")}"
    }
  }

    provisioner "file" {
    source      = "vagrant/provision/csgoserver.cfg"
    destination = "/provision/csgoserver.cfg"

    connection {
      host        = "${aws_instance.csgo_ansible_instance.public_dns}"
      type        = "ssh"
      user        = "${var.ami_user}"
      private_key = "${file("${var.private_key}")}"
    }
  }

    provisioner "file" {
    source      = "vagrant/provision/send_webhook.sh"
    destination = "/tmp/send_webhook.sh"

    connection {
      host        = "${aws_instance.csgo_ansible_instance.public_dns}"
      type        = "ssh"
      user        = "${var.ami_user}"
      private_key = "${file("${var.private_key}")}"
    }
  }

    provisioner "file" {
    source      = "vagrant/provision/send_webhook_destroy.sh" 
    destination = "/tmp/send_webhook_destroy.sh"

    connection {
      host        = "${aws_instance.csgo_ansible_instance.public_dns}"
      type        = "ssh"
      user        = "${var.ami_user}"
      private_key = "${file("${var.private_key}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/os_dependencies.sh",
      "sudo /tmp/os_dependencies.sh",
      "ansible-playbook /tmp/gsm.yaml",
      "sudo chmod +x /tmp/send_webhook.sh",
      "/tmp/send_webhook.sh"

    ]

    connection {
      host        = "${aws_instance.csgo_ansible_instance.public_dns}"
      type        = "ssh"
      user        = "${var.ami_user}"
      private_key = "${file("${var.private_key}")}"
    }
  }
}
