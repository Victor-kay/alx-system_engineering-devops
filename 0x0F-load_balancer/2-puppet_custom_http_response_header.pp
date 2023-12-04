#!/usr/bin/env bash
# Puppet manifest to configure Nginx on a new Ubuntu machine with a custom HTTP response header (X-Served-By).

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Define Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

# Create a custom HTTP response header
file { '/etc/nginx/conf.d/custom_headers.conf':
  ensure  => present,
  content => "add_header X-Served-By $::hostname;",
  notify  => Service['nginx'],
}

# Ensure Nginx is configured to include custom_headers.conf
file { '/etc/nginx/sites-available/default':
  ensure  => link,
  target  => '/etc/nginx/conf.d/custom_headers.conf',
  require => File['/etc/nginx/conf.d/custom_headers.conf'],
}

# Test Nginx configuration for syntax errors
exec { 'nginx_test_config':
  command     => 'nginx -t',
  refreshonly => true,
  notify      => Service['nginx'],
}

# Restart Nginx if configuration is valid
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Exec['nginx_test_config'],
}
