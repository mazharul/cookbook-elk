#
# Cookbook Name:: es-elk
# Recipe:: nginx-kibana
#
# Copyright (c) 2016 The Authors, All Rights Reserved.



package "nginx"


directory node[:nginx][:dir] do
  owner 'root'
  group 'root'
  mode '0755'
end

directory node[:nginx][:log_dir] do
  mode 0755
  owner node[:nginx][:user]
  action :create
end


template "nginx.conf" do
  path "#{node[:nginx][:dir]}/nginx.conf"
  source "nginx-kibana.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

include_recipe "nginx::service"

service "nginx" do
  action [ :enable, :start ]
end