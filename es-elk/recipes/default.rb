#
# Cookbook Name:: es-elk
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# 

# Not creating user explicitely because we will install elasticsearch from package
# 
elasticsearch_user 'elasticsearch'
# Install es 

elasticsearch_install 'elasticsearch' do
	type :package
end

# Set half the memory of the instance
# 

elasticsearch_configure 'elasticsearch' do
	allocated_memory '512m'
	configuration({
		'cluster.name' => 'universe',
  	'discovery.type' => 'ec2',
  	'discovery.ec2.groups' => 'es-cluster',
  	'discovery.ec2.availability_zones' => 'ap-southeast-1a',
  	'cloud.aws.region' => 'ap-southeast-1',
  	'discovery.zen.ping.multicast.enabled' => 'false',
    'network.host' => '0.0.0.0'
	})
end

elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end

# install plugin
# 

elasticsearch_plugin 'cloud-aws' do
	action :install
  notifies :restart, 'elasticsearch_service[elasticsearch]', :delayed
end

elasticsearch_plugin 'kopf' do
  url 'lmenezes/elasticsearch-kopf'
  action :install
  notifies :restart, 'elasticsearch_service[elasticsearch]', :delayed
end
