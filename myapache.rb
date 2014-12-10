package "httpd" do
  action :install
end

file "/var/www/html/index.html" do
  content "Hello, world!"
  action :create
end

service "httpd" do
  supports :restart => :true
  action [:enable, :start]
end


