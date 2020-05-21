# == Class: solr::install
# This class installs the required packages for jetty
#
# === Actions
# - Installs default jdk
# - Installs jetty and extra libs
#

class solr::install (
  $jetty_package       = $::solr::params::jetty_package,
  $jetty_extra_package = $::solr::params::jetty_extra_package,
  ) inherits ::solr::params
{

  if ! defined(Package['default-jdk']) {
      package { 'default-jdk':
        ensure    => present,
      }
  }

  if ! defined(Package[$jetty_package]) {
      package { $jetty_package:
          ensure  => present,
          alias   => 'jetty',
          require => Package['default-jdk'],
      }
  }

  if ! defined(Package[$jetty_extra_package]) {
      package { $jetty_extra_package:
          ensure  => present,
          alias   => 'libjetty-extra',
          require => Package[$jetty_package],
      }
  }

  if ! defined(Package['wget']) {
      package { 'wget':
          ensure  => present,
      }
  }

  if ! defined(Package['curl']) {
      package { 'curl':
          ensure  => present,
      }
  }

}
