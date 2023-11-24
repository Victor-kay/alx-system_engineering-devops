# 2-execute_a_command.pp

exec { 'kill_process':
  command => 'pkill -f killmenow',
  provider    => 'shell'.
}
