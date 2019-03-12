class nginx::config(
  String $config_dir            = $::nginx::config_dir,
  String $ensure                = $::nginx::config_ensure,
  String $mode                  = $::nginx::config_mode,
  String $owner                 = $::nginx::config_owner,
  String $group                 = $::nginx::config_group,
  String $confd                 = $::nginx::config_confd,
  String $log_dir               = $::nginx::config_log_dir,
  String $pid_file              = $::nginx::config_pid_file, 
  Optional[String] $vdir_enable = $::nginx::config_vdir_enable,
  String $process_user          = $::nginx::string_process_user, 
  String $docroot               = $::nginx::docroot,
) {
  file { 'nginx_config':
    ensure => $ensure,
    path   => "${config_dir}/nginx.conf",
    mode   => $mode,
    owner  => $owner,
    group  => $group,
    content => template("${module_name}/conf.d/nginx.conf.erb"),
  }

  file { '$log_dir':
    ensure  => directory,
    recurse => true,
  }
  
  file { '$docroot':
    ensure  => directory,
    recurse => true,
    mode    => $mode,
    owner   => $owner,
    group   => $group,
  }
}
