# generated by agent_generator.rb, manual changes will be lost

class pacemaker::stonith::fence_rsb (
  $ipaddr = undef,
  $login = undef,
  $passwd = undef,
  $secure = undef,
  $cmd_prompt = undef,
  $ipport = undef,
  $inet4_only = undef,
  $inet6_only = undef,
  $passwd_script = undef,
  $identity_file = undef,
  $ssh_options = undef,
  $verbose = undef,
  $debug = undef,
  $power_timeout = undef,
  $shell_timeout = undef,
  $login_timeout = undef,
  $power_wait = undef,
  $delay = undef,
  $retry_on = undef,

  $interval = "60s",
  $ensure = present,
  $pcmk_host_list = undef,
) {
  $real_address = "$(corosync-cfgtool -a $(crm_node -n))"

  $ipaddr_chunk = $ipaddr ? {
    undef => "",
    default => "ipaddr=\"${ipaddr}\"",
  }
  $login_chunk = $login ? {
    undef => "",
    default => "login=\"${login}\"",
  }
  $passwd_chunk = $passwd ? {
    undef => "",
    default => "passwd=\"${passwd}\"",
  }
  $secure_chunk = $secure ? {
    undef => "",
    default => "secure=\"${secure}\"",
  }
  $cmd_prompt_chunk = $cmd_prompt ? {
    undef => "",
    default => "cmd_prompt=\"${cmd_prompt}\"",
  }
  $ipport_chunk = $ipport ? {
    undef => "",
    default => "ipport=\"${ipport}\"",
  }
  $inet4_only_chunk = $inet4_only ? {
    undef => "",
    default => "inet4_only=\"${inet4_only}\"",
  }
  $inet6_only_chunk = $inet6_only ? {
    undef => "",
    default => "inet6_only=\"${inet6_only}\"",
  }
  $passwd_script_chunk = $passwd_script ? {
    undef => "",
    default => "passwd_script=\"${passwd_script}\"",
  }
  $identity_file_chunk = $identity_file ? {
    undef => "",
    default => "identity_file=\"${identity_file}\"",
  }
  $ssh_options_chunk = $ssh_options ? {
    undef => "",
    default => "ssh_options=\"${ssh_options}\"",
  }
  $verbose_chunk = $verbose ? {
    undef => "",
    default => "verbose=\"${verbose}\"",
  }
  $debug_chunk = $debug ? {
    undef => "",
    default => "debug=\"${debug}\"",
  }
  $power_timeout_chunk = $power_timeout ? {
    undef => "",
    default => "power_timeout=\"${power_timeout}\"",
  }
  $shell_timeout_chunk = $shell_timeout ? {
    undef => "",
    default => "shell_timeout=\"${shell_timeout}\"",
  }
  $login_timeout_chunk = $login_timeout ? {
    undef => "",
    default => "login_timeout=\"${login_timeout}\"",
  }
  $power_wait_chunk = $power_wait ? {
    undef => "",
    default => "power_wait=\"${power_wait}\"",
  }
  $delay_chunk = $delay ? {
    undef => "",
    default => "delay=\"${delay}\"",
  }
  $retry_on_chunk = $retry_on ? {
    undef => "",
    default => "retry_on=\"${retry_on}\"",
  }

  $pcmk_host_value_chunk = $pcmk_host_list ? {
    undef => '$(/usr/sbin/crm_node -n)',
    default => "${pcmk_host_list}",
  }

  $resource_name = $pcmk_host_list ? {
    undef => $::hostname,
    default => "${pcmk_host_list}",
  }

  if($ensure == absent) {
    exec { "Delete stonith::fence_rsb for ${resource_name}":
      command => "/usr/sbin/pcs stonith delete stonith-fence_rsb-${real_address}",
      onlyif => "/usr/sbin/pcs stonith show stonith-fence_rsb-${real_address} > /dev/null 2>&1",
      require => Class["pacemaker::corosync"],
    }
  } else {
    package {
      "fence-agents-rsb": ensure => installed,
    } ->
    exec { "Create stonith::fence_rsb for ${resource_name}":
      command => "/usr/sbin/pcs stonith create stonith-fence_rsb-${real_address} fence_rsb pcmk_host_list=\"${pcmk_host_value_chunk}\" ${ipaddr_chunk} ${login_chunk} ${passwd_chunk} ${secure_chunk} ${cmd_prompt_chunk} ${ipport_chunk} ${inet4_only_chunk} ${inet6_only_chunk} ${passwd_script_chunk} ${identity_file_chunk} ${ssh_options_chunk} ${verbose_chunk} ${debug_chunk} ${power_timeout_chunk} ${shell_timeout_chunk} ${login_timeout_chunk} ${power_wait_chunk} ${delay_chunk} ${retry_on_chunk}  op monitor interval=${interval}",
      unless => "/usr/sbin/pcs stonith show stonith-fence_rsb-${real_address} > /dev/null 2>&1",
      require => Class["pacemaker::corosync"],
    } ->
    exec { "Add non-local constraint stonith::fence_rsb for ${resource_name}":
      command => "/usr/sbin/pcs constraint location stonith-fence_rsb-${real_address} avoids ${pcmk_host_value_chunk}"
    }
  }
}
