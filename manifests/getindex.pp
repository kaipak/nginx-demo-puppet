class puppet-challenge::getindex( $file_loc = 'https://raw.githubusercontent.com/puppetlabs/exercise-webpage/master/index.html', $index_loc = '/usr/share/nginx/html/puppet/' ) {
  file { $index_loc:
    ensure    => 'directory',
  }
  file { "$index_loc/index.html":
    ensure    => 'present',
    mode      => 0644,
    subscribe => Exec['wget-index'],
    notify    => Service['nginx'],
  }

  exec { 'wget-index':
    command => "wget -O $index_loc $file_loc",
    path    => ['/usr/bin'],
    unless  => "/usr/bin/file $index_loc",
  }
}
 
