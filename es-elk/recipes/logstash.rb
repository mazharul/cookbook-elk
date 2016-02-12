#
# Cookbook Name:: es-elk
# Recipe:: logstash
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

template "/etc/yum.repos.d/logstash.repo" do
	source 'logstash.repo.erb'
	owner 'root'
	group 'root'
end

package 'logstash'

service 'logstash' do
	action [:enable, :start]
end


template "/etc/logstash/conf.d/10-syslog-file-input.conf" do
	source "10-syslog-file-input.conf.erb"
end

template "/etc/logstash/conf.d/30-elasticsearch-output.conf" do
	source "30-elasticsearch-output.conf.erb"
end




