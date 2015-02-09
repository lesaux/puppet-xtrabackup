class xtrabackup (

  $version              = '2.2.8',
  $install_dir          = '/opt',
  $download_url         = "http://www.percona.com/downloads/XtraBackup/XtraBackup-2.2.8/binary/tarball/percona-xtrabackup-2.2.8-5059-Linux-x86_64.tar.gz",
  $symlink              = true,
  $symlink_name         = "${install_dir}/percona-xtrabackup",
  $manage_binaries_path = true,  

) {

    archive { "percona-xtrabackup-${xtrabackup::version}-Linux-x86_64":
      ensure   => present,
      checksum => false,
      target   => $xtrabackup::install_dir,
      url      => $xtrabackup::download_url,
    }

    if $xtrabackup::symlink {
      file { "$install_dir/percona-xtrabackup":
        ensure  => link,
        require => Archive["percona-xtrabackup-${xtrabackup::version}-Linux-x86_64"],
        target  => "${xtrabackup::install_dir}/percona-xtrabackup-${xtrabackup::version}-Linux-x86_64",
      }
    }

    if $xtrabackup::manage_binaries_path {
      file { '/etc/profile.d/percona-xtrabackup.sh':
        mode    => 644,
        content => "PATH=\$PATH:$xtrabackup::install_dir/percona-xtrabackup/bin",
      }
    }
}
