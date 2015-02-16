class sfu_mod_auth_cas (
  # one day we'll error out if this isn't present
  $cas_apache_module       = '/usr/lib64/httpd/modules/mod_auth_cas.so', 
  $auth_cas_conf           = '/etc/httpd/conf.d/auth_cas.conf',
  $auth_cas_load           = '/etc/httpd/conf.d/auth_cas.load',
  $ca_cert_bundle_path     = '/etc/ssl/certs/ThawtePremiumServerBundleCA.pem',
  $ca_cert_bundle_source   = 'http://www.sfu.ca/content/dam/sfu/itservices/publishing/cas/ThawtePremiumServerBundleCA.pem',
  $cas_cookie_path         = '/var/cascookies/', # mod_auth_cas wants a trailing slash
  $cas_login_url           = 'https://cas.sfu.ca/cas/login',
  $cas_validate_url        = 'https://cas.sfu.ca/cas/serviceValidate',
  $cas_tickets_url         = 'https://cas.sfu.ca/cas/rest/v1/tickets',
  $cas_allow_wildcard_cert = 'Off',
  $cas_validate_server     = 'On',
  ) {

  case $::operatingsystem {
    redhat, centos, fedora: {      
      wget::fetch { $ca_cert_bundle_path:
        source      => $ca_cert_bundle_source,
        destination => $ca_cert_bundle_path,
        timeout     => 30,
        verbose     => false,
      }
      
      concat { $auth_cas_conf:
        warn    => true,
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
      }

      concat { $auth_cas_load:
        warn    => true,
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
      }

      
      concat::fragment { 'auth_cas.load.base':
        target  => $auth_cas_load,
        order   => 10,
        content => template('sfu_mod_auth_cas/auth_cas.load.erb'),
      }
      
      concat::fragment { 'auth_cas.conf.base':
        target  => $auth_cas_conf,
        order   => 05,
        content => template('sfu_mod_auth_cas_sfu/auth_cas.conf.erb'),
      }
      
      file { $cas_cookie_path:
        ensure  => directory,
        recurse => true,
        mode    => '0770',
        owner   => 'apache',
        group   => 'apache',
      }
    }
    default: {
      fail('Unsupported operating system')
    }
  }
}
