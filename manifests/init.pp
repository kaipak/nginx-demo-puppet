# Configure nginx webpage and serve up demo page on port 8000
# Require: maestrodev/wget, jfryman/nginx
#
class nginx_puppet_demo (
  $nginx_conf = '/etc/nginx/sites-available/puppet-nginx.conf',
  $www_root  = '/usr/share/nginx/html/puppet/'
) {
  
  class { 'nginx': }
  
  nginx::resource::vhost{ 'localhost':
    listen_port  => 8000,
    www_root     => $www_root,
  }

  file { "$www_root":
    ensure    => 'directory',
    require   => Package['nginx'],
  }

  wget::fetch { "Puppet Index":
    source      => 'https://raw.githubusercontent.com/kaipak/exercise-webpage/master/index.html',
    destination => "${www_root}/index.html",
    timeout     => 0,
    verbose     => true,
    require     => File[$www_root],
  }
}
