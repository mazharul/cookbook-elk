#
# Cookbook Name:: es-elk
# Recipe:: kibana
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# 
#

template "/etc/yum.repos.d/kibana.repo" do
  source "kibana.repo.erb"
  owner "root"
  group "root"
end

package "kibana"

service 'kibana' do
  action [:enable, :start]
end



