class puppet-challenge {
    class { '::puppet-challenge::nginx': } 
    class { '::puppet-challenge::getindex': }
}
