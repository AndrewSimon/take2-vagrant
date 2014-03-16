#  Written by Andrew Simon
## Puppet manifest run by Vagrantfile on vagrant up / provision / reload
# 

class install_rpms {
  package {['ntpdate', 'wget', 'httpd', 'php']: ensure => 'present'
  }
}

class set_date {
 exec { 'set_date':
  command => 'ntpdate us.pool.ntp.org',
  path => '/usr/sbin:/bin:/usr/bin',
  user => 'root',
  require => Package['ntpdate'],
 } 
}

class configure_home_pages {
 file {'/var/www/html/index.php':
      ensure  => present,
      mode => 0644,
      content => "<?php phpinfo(); ?>",
    }
## These could go in configure_vhosts class to use the docroot variable
 file {'/var/www/html2':
      ensure  => directory,
      mode => 0644,
      content => "<H1>Hello World</H1>",
      before => File['/var/www/html2/index.html'],
    }
 file {'/var/www/html2/index.php':
      ensure  => present,
      mode => 0644,
      content => "<H1>Hello World</H1>",
    }
}

class configure_vhosts {
## Uses a template for httpd.conf and vhosts.conf
 $hostname = 'localhost'
 $port = '81'
 $docroot = '/var/www/html2'
 file { "/etc/httpd/conf.d/vhosts.conf":
    ensure => file,
    mode => 0644,
    content => template("/vagrant/templates/vhosts.erb"),
  }
 file { "/etc/httpd/conf/httpd.conf":
    ensure => file,
    mode => 0644,
    content => template("/vagrant/templates/httpd.erb"),
  }
}

class start_apache_service {
  service { 'httpd': ensure => running, enable => true, require => Package['httpd'], subscribe => File['/etc/httpd/conf.d/vhosts.conf'],
} 
}


include install_rpms 
include set_date
include configure_home_pages
include configure_vhosts
include start_apache_service
