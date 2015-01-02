require 'serverspec'
require 'net/http'

set :backend, :exec

describe "myapache" do
  it "has httpd package installed" do
    expect(package('httpd')).to be_installed
  end

 it "displays home page on port 8080 & 8081" do
    expect(Net::HTTP.get_response(URI("http://localhost:8080")).body).to match /8080/
    expect(Net::HTTP.get_response(URI("http://localhost:8081")).body).to match /8081/  end

 it "returns a proper response code" do
    expect(Net::HTTP.get_response(URI("http://localhost:8080")).code).to eq "200"
    expect(Net::HTTP.get_response(URI("http://localhost:8081")).code).to eq "200"
  end
end


