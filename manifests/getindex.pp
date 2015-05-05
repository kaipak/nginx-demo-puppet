class puppet-challenge::getindex (
   $file_loc = 'https://raw.githubusercontent.com/puppetlabs/exercise-webpage/master/index.html',
   $index_loc = '/usr/share/nginx/html/puppet/') 
{
  include puppet-challenge::nginx 

  file { $index_loc:
    ensure    => 'directory',
  }
  file { "$index_loc/index.html":
    ensure    => 'present',
    mode      => 0644,
    source    => 'puppet:///modules/puppet-challenge/index.html',
    require => Exec['wget-index'],
    notify    => Service['nginx'],
  }

  exec { 'wget-index':
    command => "wget -O /etc/puppet/modules/puppet-challenge/files/index.html ${file_loc}",
    path    => ['/usr/bin', '/bin'],
  }
}
 
