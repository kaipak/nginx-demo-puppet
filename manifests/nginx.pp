# Class to install nginx and listen on port 8000

class puppet-challenge::nginx( $nginx_conf = '/etc/nginx/sites-available/puppet-nginx.conf')
{

  package { 'nginx':
    ensure  => 'installed',
    # require => Exec['apt-get-update'],
  }
  
  file { $nginx_conf:
    ensure => 'present',
    source => 'puppet:///modules/puppet-challenge/puppet-nginx.conf',
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => 'link',
    target => $nginx_conf,
  }
    
  #exec { 'apt-get-update':
  #  command => "apt-get update",
  #  path => [ '/usr/bin', '/bin' ],
  #}

  service { 'nginx':
    ensure => 'running',
    enable => 'true',
    require => Package['nginx'],
    subscribe => File[$nginx_conf],
  }
}

