variable "ssh_host_presta" {}
variable "ssh_user_presta" {}
variable "ssh_key_presta" {}
resource "null_resource" "ssh_target" {
        connection {
                type    =       "ssh"
                user            =       var.ssh_user_presta
                host    =       var.ssh_host_presta
                private_key = file(var.ssh_key_presta)
    }
    provisioner "remote-exec" {
        inline= [
         "sudo apt update",
         "sudo apt install -y apache2 wget unzip php libapache2-mod-php mariadb-server php-mysqli php-mbstring php-curl php-gd php-simplexml php-intl php-ldap php-apcu php-xmlrpc php-cas php-zip php-bz2 php-ldap php-imap apcupsd php-apcu",
         "sudo a2enmod rewrite",
         "sudo systemctl restart apache2",
         "sudo wget https://github.com/PrestaShop/PrestaShop/releases/download/1.7.8.8/prestashop_1.7.8.8.zip",
         "sudo mkdir /presta",
         "sudo unzip prestashop_1.7.8.8.zip -d /presta",
         "sudo rm /var/www/html/*",
         "sudo mv ~ prestashop/* /var/www/html",
         "sudo chown -R www-data:www-data /var/www/html",
         "sudo chmod 775 /var/www/html",


         ]
        }
}
