wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb  # Download the package
sudo dpkg -i puppetlabs-release-pc1-xenial.deb				  # Extract the packe to the system
sudo apt-get update											  # refresh of repos
sudo apt-get install puppet-agent							  # 


file {'/tmp/it_works.txt':                        # resource type file and filename
  ensure  => present,                             # make sure it exists
  mode    => '0644',                              # file permissions
  content => "It works !!",  # Print the eth0 IP fact
}

user { 'mridhul':
  ensure     => present,
  uid        => '1000',
  gid        => '1000',
  shell      => '/bin/bash',
  home       => '/home/mridhul'
}

puppet resource --types

---------------
node 'slave', 'slave2' {    # applies to node1 and node2 nodes
  file {'/tmp/dns':    # resource type file and filename
    ensure => present, # make sure it exists
    mode => '0644',
    content => "Only DNS servers get this file.\n",
  }
}

node default {}       # applies to nodes that aren't explicitly defined
-----------------


node 'slave' {
  class { 'apache': }             # use apache module
  apache::vhost { 'example.com':  # define vhost resource
    port    => '80',
    docroot => '/var/www/html'
  }
}

=================
 /etc/puppet/manifests/lamp.pp
 
Apache package (apache2) installed
Apache service (apache2) running
MySQL Server package (mysql-server) installed
MySQL Server service (mysql) running
PHP5 package (php5) installed
A test PHP script file (info.php)
create a index.php file with some content
Update apt before installing packages

=====
# execute 'apt-get update'
exec { 'apt-update':                    # exec resource named 'apt-update'
  command => '/usr/bin/apt-get update'  # command this resource will run
}

# install apache2 package
package { 'apache2':
  require => Exec['apt-update'],        # require 'apt-update' before installing
  ensure => installed,
}

# ensure apache2 service is running
service { 'apache2':
  ensure => running,
}

# install mysql-server package
package { 'mysql-server':
  require => Exec['apt-update'],        # require 'apt-update' before installing
  ensure => installed,
}

# ensure mysql service is running
service { 'mysql':
  ensure => running,
}

# install php7 package
package { 'php':
  require => Exec['apt-update'],        # require 'apt-update' before installing
  ensure => installed,
}

# ensure info.php file exists
file { '/var/www/html/info.php':
  ensure => file,
  content => '<?php  phpinfo(); ?>',    # phpinfo code
  require => Package['apache2'],        # require 'apache2' package before creating
} 

# ensure index.php file exists
file { '/var/www/html/index.php':
  ensure => file,
  content => 'Welcome to my file',    # phpinfo code
  require => Package['apache2'],        # require 'apache2' package before creating
} 

========================================================================================

Lamp with Module

Master
cd /etc/puppet/modules
sudo mkdir -p lamp/manifests
vim.tiny lamp/manifests/init.pp

class lamp {

##Contents

}

>>Edit site.pp

node default { }

node 'slave' {
	include lamp

}


=========================================================================================================
Reference:
https://www.digitalocean.com/community/tutorials/how-to-install-puppet-4-in-a-master-agent-setup-on-ubuntu-14-04
https://www.digitalocean.com/community/tutorials/getting-started-with-puppet-code-manifests-and-modules
