resource "null_resource" "fazendoshell" {

    triggers = {
        always_run = "${timestamp()}"
    }

    provisioner "local-exec" {
        command = "/bin/bash teste.sh"
    }
}