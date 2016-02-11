
# We will  handle nginx configuration separately
default['kibana']['webserver'] = '' # nginx or apache
default['kibana']['install_type'] = 'git'
default['kibana']['git']['url'] = 'https://github.com/elastic/kibana'
default['kibana']['git']['branch'] = 'v4.3.1'


# We will install updated version of logstash
default['logstash']['instance_default']['version']        = '2.1.2'