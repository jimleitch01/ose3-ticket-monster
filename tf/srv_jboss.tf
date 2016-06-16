resource "openstack_networking_floatingip_v2" "jboss_fp" {
  region = ""
  pool = "${var.my-ip-pool}"
}


resource "openstack_compute_instance_v2" "jboss" {
count = "1"
name = "demo-jboss"
image_name = "CentOS7"
flavor_name = "m1.medium"
security_groups = ["allow_everything-demo"]
/*security_groups = ["allow_everything-infra-sec"]*/
key_pair = "jim-key"
floating_ip = "${openstack_networking_floatingip_v2.jboss_fp.address}"
network {
  name = "${var.infra-net-name}"
  fixed_ip_v4 = "10.0.0.33"
}

#depends_on = ["openstack_compute_instance_v2.bastion"]

    connection {
        type = "ssh"
        user = "centos"
       timeout = "${var.ssh-timeout}"
        agent = "true"
        bastion_host = "bastion.test-rig.net"
      }

      provisioner "file" {
         source = "../layer2/puppet_modules.tgz"
         destination = "/tmp/puppet_modules.tgz"
       }

       provisioner "file" {
          source = "../layer2/init.pp"
          destination = "/tmp/init.pp"
        }

# Wait until hostname is correct
    provisioner "remote-exec" {
       inline = [
       "echo ===========================",
       "echo WAIT UNTIL HOSTNAME CORRECT",
       "echo ===========================",
       "set -e",
       "set -x",

       "while [[ $(hostname) != '${format("${var.cloud-name}-jboss%02d", count.index )}' ]] ; do sleep 5; echo Waiting for hostname to be set to ${format("${var.cloud-name}-jboss%02d", count.index )} ;  done"
       ]
     }

     # Set facter variables
     provisioner "remote-exec" {
        inline = [
        "echo ===========================",
        "echo SET FACTER VARS",
        "echo ===========================",

        "set -e",
        "set -x",
        "sudo mkdir -p /etc/facter/facts.d",
        "sudo sh -c 'echo --- > /etc/facter/facts.d/test-rig-config.yaml'",
        "sudo sh -c 'echo color: ${var.cloud-name} >> /etc/facter/facts.d/test-rig-config.yaml'",
        "sudo sh -c 'echo role: net.test-rig.jboss000 >> /etc/facter/facts.d/test-rig-config.yaml'",

        "echo successfully set facts color=${var.cloud-name} "
        ]
      }

      provisioner "remote-exec" {
         inline = [

         "echo ===========================",
         "echo PUPPET INSTALL, MODULES INSTALL, MANIFEST COPY",
         "echo ===========================",
         "set -e",
         "set -x",
        "sudo yum  -y -q install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
          "sudo yum -y -q install puppet wget unzip xz",
          "sudo sh -c 'cd /tmp; wget http://nexus.test-rig.net:8081/service/local/repositories/releases/content/net/test-rig/project/1.0.0/project-1.0.0.war'",
          /*"sudo bash /tmp/puppet_modules.bash",*/
          "sudo sh -c 'cd / ; tar xvzf /tmp/puppet_modules.tgz'",
          "sudo mkdir -p /etc/puppet/manifests",
          "sudo cp /tmp/init.pp /etc/puppet/manifests"

        ]
        }
     #Ensure hostname is what you want it to be
     provisioner "remote-exec" {
        inline = [
        "echo ===========================",
        "echo SETTING HOSTNAME",
        "echo ===========================",

        "set -e",
        "set -x",

        "sudo sh -c 'echo hostname: ${format("${var.cloud-name}-jboss%02d", count.index )} > /etc/cloud/cloud.cfg.d/99_hostname.cfg'",

        "sudo sh -c 'echo fqdn: ${format("${var.cloud-name}-jboss%02d", count.index )}.test-rig.net >> /etc/cloud/cloud.cfg.d/99_hostname.cfg'",

        "sudo sh -c 'echo  $(facter ipaddress_eth0) ${format("${var.cloud-name}-jboss%02d", count.index )} ${format("${var.cloud-name}-jboss%02d", count.index )}.test-rig.net >> /etc/hosts'",
              ]
      }


      #Puppet Apply
      provisioner "remote-exec" {
         inline = [
         "echo ===========================",
         "echo PUPPET APPLYING",
         "echo ===========================",
         "set -e",
         "set -x",
         "sudo puppet apply --modulepath /etc/puppet/modules /etc/puppet/manifests --debug"
        ]
        }







}
