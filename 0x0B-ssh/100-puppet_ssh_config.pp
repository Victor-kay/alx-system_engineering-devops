# 100-puppet_ssh_config.pp

# Puppet manifest to configure SSH client

# Ensure the SSH client configuration file is present
file { '/etc/ssh/ssh_config':
  ensure => present,
}

# Turn off password authentication in sshd_config
file_line { 'Turn off passwd auth':
  path   => '/etc/ssh/sshd_config',
  line   => 'PasswordAuthentication no',
}

# Declare identity file in ssh_config
file_line { 'Declare identity file':
  path   => '/etc/ssh/ssh_config',
  line   => '    IdentityFile ~/.ssh/school',
  before => 'Host *',
}
