class rest_haproxy(
  $root   = '/opt/rest_haproxy/'
  $source = 'http://download.srcclr.com/rest_haproxy/rest_haproxy'
  $path   = "${root}/rest_haproxy"
){
  file { $root:
    ensure => directory,
  }

  exec { "wget_rest_haproxy":
    command     => "/usr/bin/wget -q ${source} -O ${path}",
    creates     => $path,
    notify      => Service['rest_haproxy'],
  }

  file { $path:
    mode    => '0755',
    require => Exec["wget_rest_haproxy"]
  }

  file { '/etc/init.d/rest_haproxy':
    ensure  => file,
    mode    => 0755,
    notify  => Service['rest_haproxy'],
  }

  service { 'rest_haproxy':
    ensure  => running,
    enable  => true,  
  }  
}
