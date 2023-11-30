# site.pp

# Comment explaining the purpose of the Puppet script
# This Puppet manifest installs and configures Nginx on an Ubuntu machine with specific requirements.

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx to listen on port 80
file { '/etc/nginx/sites-available/default':
  ensure => present,
  content => template('nginx/default.erb'),
  notify => Service['nginx'],
}

# Create a custom index page
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

# Enable the site configuration
file { '/etc/nginx/sites-enabled/default':
  ensure => link,
  target => '/etc/nginx/sites-available/default',
  notify => Service['nginx'],
}

# Define a location block for the 301 redirect
file { '/etc/nginx/sites-available/redirect_me':
  ensure => present,
  content => template('nginx/redirect_me.erb'),
  notify => Service['nginx'],
}

# Enable the site configuration for /redirect_me
file { '/etc/nginx/sites-enabled/redirect_me':
  ensure => link,
  target => '/etc/nginx/sites-available/redirect_me',
  notify => Service['nginx'],
}

# Nginx service
service { 'nginx':
  ensure => running,
  enable => true,
}
