# puppet-sfu_mod_auth_cas

Manages the SFU flavour of mod_auth_cas for Apache on CentOS.


### Dependencies

* manually compiled mod_auth_cas
* https://forge.puppetlabs.com/maestrodev/wget


### Usage

```
class { 'sfu_mod_auth_cas': }
```

Override the defaults as needed:

```
class { 'sfu_mod_auth_cas':
   ca_cert_bundle_path => 'TotallyNotVulnerableBundle.pem',
   cas_cookie_path => '/var/www/cascookies',
}
```

### Parameters

**cas_apache_module** 

One day when this modules doesn't suck, we'll actually check that you've compiled and installed mod_auth_cas.


**auth_cas_conf**

Location of auth_cas.conf include file. Default: /etc/httpd/conf.d/auth_cas.conf


**auth_cas_load**

Location of auth_cas.load include file. Default: /etc/httpd/load.d/auth_cas.load


**ca_cert_bundle_path**

CASCertificatePath for mod_auth_cas. Default: /etc/ssl/certs/ThawtePremiumServerBundleCA.pem


**ca_cert_bundle_source**

URL of current ThawtePremiumServerBundleCA.pem.


**cas_cookie_path**

CASCookiePath for mod_auth_cas, which insists on a trailing slash here. Default: /var/cascookies/

**cas_root_proxied_as**

CASRootProxiedAs for mod_auth_cas, for internal web servers behind e.g., load balancers.


Other mod_auth_cas parameters you can override:
cas_login_url
cas_validate_url
cas_tickets_url
cas_allow_wildcard_cert
cas_validate_server

### Version
0.1 - 18-Feb-2015 - Initial release


