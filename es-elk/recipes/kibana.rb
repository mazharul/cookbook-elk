#
# Cookbook Name:: es-elk
# Recipe:: kibana
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# 
#

install_type = node['kibana']['install_type']

unless Chef::Config[:solo]
  es_server_results = search(:node, "roles:#{node['kibana']['es_role']} AND chef_environment:#{node.chef_environment}")
  unless es_server_results.empty?
    node.set['kibana']['es_server'] = es_server_results[0]['ipaddress']
  end
end

if node['kibana']['user'].empty?
  if !node['kibana']['webserver'].empty?
    webserver = node['kibana']['webserver']
    kibana_user = node[webserver]['user']
  else
    kibana_user = 'nobody'
  end
else
  kibana_user = node['kibana']['user']
  kibana_user kibana_user do
    name kibana_user
    group kibana_user
    home node['kibana']['install_dir']
    action :create
  end
end

kibana_install 'kibana' do
  user kibana_user
  group kibana_user
  install_dir node['kibana']['install_dir']
  install_type install_type
  action :create
end

docroot = "#{node['kibana']['install_dir']}/current/kibana"
kibana_config = "#{node['kibana']['install_dir']}/current/#{node['kibana'][install_type]['config']}"
es_server = "#{node['kibana']['es_scheme']}#{node['kibana']['es_server']}:#{node['kibana']['es_port']}"

template kibana_config do
  source node['kibana'][install_type]['config_template']
  cookbook node['kibana'][install_type]['config_template_cookbook']
  mode '0644'
  user kibana_user
  group kibana_user
  variables(
    index: node['kibana']['config']['kibana_index'],
    port: node['kibana']['java_webserver_port'],
    elasticsearch: es_server,
    default_route: node['kibana']['config']['default_route'],
    panel_names:  node['kibana']['config']['panel_names'],
    default_app_id: node['kibana']['config']['default_app_id']
  )
end

if install_type == 'file'

  include_recipe 'java::default' if node['kibana']['install_java']
  include_recipe 'runit::default'

  runit_service 'kibana' do
    options(
      user: kibana_user,
      home: "#{node['kibana']['install_dir']}/current"
    )
    cookbook 'kibana_lwrp'
    subscribes :restart, "template[#{kibana_config}]", :delayed
  end

end
