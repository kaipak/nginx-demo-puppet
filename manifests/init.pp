# Configure nginx webpage and serve up demo page on port 8000
#

class nginx_puppet_demo (
  $nginx_conf = '/etc/nginx/sites-available/puppet-nginx.conf',
  $index_loc  = '/usr/share/nginx/html/puppet/'
) {

  package { 'nginx':
    ensure  => 'installed',
  }

  file { $nginx_conf:
    ensure => 'present',
    source => 'puppet:///modules/nginx_puppet_demo/puppet-nginx.conf',
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => 'link',
    target => $nginx_conf,
  }

  file { $index_loc:
    ensure    => 'directory',
  }

  wget::fetch { "Puppet Index":
    source      => 'https://raw.githubusercontent.com/puppetlabs/exercise-webpage/master/index.html',
    destination => "${index_loc}/index.html",
    timeout     => 0,
    verbose     => true,
  }

  service { 'nginx':
    ensure => 'running',
    enable => 'true',
    require => Package['nginx'],
    subscribe => File[$nginx_conf],
  }
}
