resource "null_resource" "provision" {
  count = var.instance_count

  connection {
    user        = "ec2-user"
    private_key = file("id_rsa")
    host        = element(module.ec2.public_dns, count.index)
    timeout     = "5m"
  }

  triggers = {
    INSTANCES     = join(",", module.ec2.public_dns)
    SCRIPT_DEPLOY = md5(file("provision.sh"))
    PASSWORD      = var.password
  }

  provisioner "local-exec" {
    command = "(cd ..;tar -cf - exercise*) > homedir.tar"
  }

  provisioner "file" {
    source      = "homedir.tar"
    destination = "/tmp/homedir.tar"
  }

  provisioner "remote-exec" {
    inline = [
      "echo connected",
    ]
  }

  provisioner "file" {
    source      = "provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provision.sh",
      "/tmp/provision.sh ${var.password}",
    ]
  }
}
