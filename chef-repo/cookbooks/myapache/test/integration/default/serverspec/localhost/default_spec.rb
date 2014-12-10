require 'serverspec'
set :backend, :exec

describe "apache" do
  it "has httpd package installed" do
    expect(package('httpd')).to be_installed
  end

  it "displays chess home page on port 80" do
    expect(command("curl http://localhost:80").stdout).to match /Chef Fundamentals chess website/
  end

  it "displays draughts home page on port 81" do
    expect(command("curl http://localhost:81").stdout).to match /Chef Fundamentals draughts website/
  end
end


