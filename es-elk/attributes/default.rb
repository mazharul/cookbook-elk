
# We will  handle nginx configuration separately
default['kibana']['webserver'] = '' # nginx or apache
default['kibana']['install_type'] = 'git'
default['kibana']['git']['url'] = 'https://github.com/elastic/kibana'
default['kibana']['git']['branch'] = 'v4.3.1'


# We will install updated version of logstash
default['logstash']['instance_default']['version'] = '2.2.0'
default['logstash']['instance_default']['source_url']     = 'https://github.com/elastic/logstash/archive/v2.2.0.tar.gz'
default['logstash']['instance_default']['checksum']       = 'c8cc02b28340c7569dfc5b044d30ea4cd33602873a27097f7232113e144c00fe'
default['logstash']['instance_default']['install_type']   = 'tarball'