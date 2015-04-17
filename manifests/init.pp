# == Class: nx
#
# Full description of class nx here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { nx:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class nx {

  file{
    "/tmp/nxclient-3.5.0-6.x86_64.rpm":
      source => "puppet:///modules/nx/nxclient-3.5.0-6.x86_64.rpm";
    
    "/tmp/nxnode-3.5.0-3.x86_64.rpm":
      source => "puppet:///modules/nx/nxnode-3.5.0-3.x86_64.rpm";
    
    "/tmp/nxserver-3.5.0-4.x86_64.rpm":
      source => "puppet:///modules/nx/nxserver-3.5.0-4.x86_64.rpm";
  }
  
  Package{ensure => installed, provider => "rpm"}
  
  package{
    "nxclient":
      source => "/tmp/nxclient-3.5.0-6.x86_64.rpm",
      require => File["/tmp/nxclient-3.5.0-6.x86_64.rpm"];
    
    "nxnode":
      source => "/tmp/nxnode-3.5.0-3.x86_64.rpm",
      require => File["/tmp/nxnode-3.5.0-3.x86_64.rpm"];
    
    "nxserver":
      source => "/tmp/nxserver-3.5.0-4.x86_64.rpm",
      require => File["/tmp/nxserver-3.5.0-4.x86_64.rpm"]
  }
  
  service{"nxserver":
    enable => true,
    ensure => running,
    status => "/bin/ls /var/lock/subsys/nxserver",
    require => Package["nxserver"]
  }
  
  file {"/usr/NX/etc/server.cfg":
    source => "puppet:///modules/nx/server.cfg",
    require => Service["nxserver"]
  }
  
}
