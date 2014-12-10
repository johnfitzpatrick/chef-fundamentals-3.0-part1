file "hello.txt" do
  content "Hello, world!"
  action :create
  mode "0777"
  owner "chef"
  group "chef"
end

