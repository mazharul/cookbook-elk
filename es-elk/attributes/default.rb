
# We will  handle nginx configuration separately
default['kibana']['webserver'] = '' # nginx or apache
default['kibana']['install_type'] = 'git'
default['kibana']['git']['url'] = 'https://github.com/elastic/kibana'
default['kibana']['git']['branch'] = 'v4.3.1'


# We will install updated version of logstash
default['logstash']['instance_default']['version']        = '2.2.0'
default['logstash']['instance_default']['source_url']     = 'https://download.elastic.co/logstash/logstash/logstash-2.2.0.tar.gz'
default['logstash']['instance_default']['checksum']    	  = 'aee2437f45c726ec354f0bf9634b3638428d48bef32beb412f827eb2cc736f78'