# Class to install nginx and listen on port 2718

class puppet-challenge::nginx {
  package { 'nginx':
    ensure  => 'present',
    require => Exec['apt-get-update'],
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => 'present',
    source => 'puppet:///modules/puppet-challenge/nginx.conf'
  }
    
  exec { 'apt-get-update':
    command => "apt-get update",
    path => [ '/usr/bin', '/bin' ],
  }
}
