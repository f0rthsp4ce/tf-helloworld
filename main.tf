// The droplet is used as the host runner on Digital Ocean 
// to run jobs in your GitHub Actions workflows.

# Render registration.sh using a `templatefile`
data "template_file" "reg_script" {
  template = "${file("${path.module}/register.sh.tpl")}"
  vars = {
    GITHUB_ACCESS_TOKEN = "${var.github_access_token}"
    GITHUB_REPO_NAME    = "${var.github_repo_name}"
  }
}

data "template_cloudinit_config" "script" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.reg_script.rendered}"
  }
}

resource "digitalocean_droplet" "gh-runner" {
  name      = "gh-runner-${format("%02d", count.index + 1)}"
  count     = "1"
  size      = "s-1vcpu-1gb"
  image     = "ubuntu-20-04-x64"
  region    = "ams3"
  ssh_keys  = [
    "${data.digitalocean_ssh_key.terraform.id}"
  ]
  user_data = "${data.template_cloudinit_config.script.rendered}"
}
