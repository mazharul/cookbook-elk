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
	allocated_memory '2G'
	configuration({
		'cluster.name' => 'universe',
      	'node.name' => 'milkyway',
      	'discovery.type' => 'ec2',
      	'discovery.ec2.groups' => 'elasticsearch cluster',
      	'discovery.ec2.availability_zones' => 'ap-southeast-1a',
      	'cloud.aws.region' => 'ap-southeast',
      	'discovery.zen.ping.multicast.enabled' => 'false'
	})
end

elasticsearch_service 'elasticsearch'


# install plugin
# 

elasticsearch_plugin 'cloud-aws' do
	action :install
end

elasticsearch_plugin 'kopf' do
  url 'lmenezes/elasticsearch-kopf'
  action :install
end
