package 'git' do
  action :install
end

file '/home/chef/.gitconfig' do
  content "[user]\n  name=John Doe\n  email=jdoe@example\n"
  user 'root'
  group 'root'
end

