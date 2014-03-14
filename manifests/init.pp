#
## Puppet manifest run by Vagrantfile on vagrant up
#

class install_rpms {
  package {['ntpdate', 'git', 'wget', 'httpd', 'php']: ensure => 'present'
  }
}

class set_date {
 exec { 'set_date':
  command => 'ntpdate us.pool.ntp.org',
  path => '/usr/sbin:/bin:/usr/bin',
  user => 'root',
 } 
}

class configure_home_pages {
file {'/var/www/html/index.php':
      ensure  => present,
      mode => 0644,
      content => "<?php phpinfo(); ?>",
    }
file {'/var/www/html2':
      ensure  => directory,
      mode => 0644,
      content => "<H1>Hello World</H1>",
      before => File['/var/www/html2/index.php'],
    }
file {'/var/www/html2/index.php':
      ensure  => present,
      mode => 0644,
      content => "<H1>Hello World</H1>",
    }
}

class configure_vhosts {
file { "/etc/httpd/sites-available/vhost_80.conf":
    mode => 0644,
    content => template("vhosts.erb"),
    nofity => Service["httpd"],
  }
file { "/etc/httpd/sites-available/vhost_81.conf":
    mode => 0644,
    content => template("vhosts.erb"),
    nofity => Service["httpd"],
  }
}

class start_apache_service {
  service { 'httpd': ensure => running, require => Package['httpd'], } 
}


include install_rpms 
include set_date
include configure_home_pages
