variable "ssh_host_glpi" {}
variable "ssh_user_glpi" {}
variable "ssh_key_glpi" {}
resource "null_resource" "ssh_target" {
        connection {
                type    =       "ssh"
                user            =       var.ssh_user_glpi
                host    =       var.ssh_host_glpi
                private_key = file(var.ssh_key_glpi)
    }
    provisioner "remote-exec" {
        inline= [
         "sudo apt update",
         "sudo apt install -y apache2 wget unzip php libapache2-mod-php mariadb-server php-mysqli php-mbstring php-curl php-gd php-simplexml php-intl php-ldap php-apcu php-xmlrpc php-cas php-zip php-bz2 php-ldap php-imap apcupsd php-apcu",
         "sudo a2enmod rewrite",
         "sudo systemctl restart apache2",
         "sudo rm rm /var/www/html/index.html",
         "sudo wget https://github.com/glpi-project/glpi/releases/download/10.0.7/glpi-10.0.7.tgz",
         "sudo tar -xvzf glpi-10.0.7.tgz",
         "sudo mv glpi/* /var/www/html",
         "sudo chown -R www-data:www-data /var/www/html",
         "sudo chmod 775 /var/www/html",
         "sudo systemctl restart apache2"

         ]
        }
}
