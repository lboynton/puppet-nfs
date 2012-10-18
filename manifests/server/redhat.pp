class nfs::server::redhat inherits nfs::client::redhat {
  
  exec {"reload_nfs_srv":
    command     => "/etc/init.d/nfs reload",
    refreshonly => true,
    require     => Package["nfs-utils"],
  }

  service {"nfs":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package["nfs-utils"],
  }

  concat {'/etc/exports':
    owner  => root,
    group  => root,
    mode   => '0644',
    notify => Exec['reload_nfs_srv'],
  }

}
