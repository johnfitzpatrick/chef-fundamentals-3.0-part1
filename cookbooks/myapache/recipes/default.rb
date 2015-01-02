#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.
#
package "httpd"

execute "mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.disabled" do 
  only_if do
    File.exist?("/etc/httpd/conf.d/welcome.conf")
  end
  notifies :restart, "service[httpd]"
end

num_web_servers = 2
web_server_listening_port = 8080

1.upto(num_web_servers).each do |web_server_id|
  document_root = "/var/www/html/web0#{web_server_id}"

  directory document_root do
    recursive true
    mode "0755"
  end

  template "/etc/httpd/conf.d/web0#{web_server_id}.conf" do
    action :create
    owner "root"
    group "root"
    mode "0644"
    source "web.conf.erb"
    variables(
      :port => web_server_listening_port,
      :web_server_id => web_server_id
    )
    notifies :restart, "service[httpd]"
  end

  template "#{document_root}/index.html" do
    action :create
    owner "root"
    group "root"
    mode "0644"
    source "index.html.erb"
    variables(
      :port => web_server_listening_port
    )
  end

  web_server_listening_port += 1
end

template "/etc/httpd/conf/httpd.conf" do
  action :create
  owner "root"
  group "root"
  mode "0644"
  source "httpd.conf.erb"
end

template "/var/www/html/index.html" do
  action :delete
  owner "root"
  group "root"
  mode "0644"
  source "index.html.erb"
end

service "httpd" do
  action [:start, :enable]
end

