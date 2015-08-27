# Configure nginx webpage and serve up demo page on port 8000
# Require: maestrodev/wget, jfryman/nginx
#
class nginx_puppet_demo (
  $nginx_conf = '/etc/nginx/sites-available/puppet-nginx.conf',
  $www_root   = '/usr/share/nginx/html/puppet/',
  $web_port   = 8000,
) {
  
  class { 'nginx': }
  
  nginx::resource::vhost{ 'localhost':
    listen_port  => $web_port,
    www_root     => $www_root,
  }

  file { "$www_root":
    ensure    => 'directory',
    require   => Package['nginx'],
  }

  wget::fetch { "Puppet Index":
    source      => 'https://raw.githubusercontent.com/kaipak/exercise-webpage/production/index.html',
    destination => "${www_root}/index.html",
    timeout     => 0,
    verbose     => true,
    require     => File[$www_root],
  }

  firewall { '100 allow connections to specified web service':
    proto   => 'tcp',
    dport   => $web_port,
    action  => 'accept',
  }

}
