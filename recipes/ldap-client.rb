
include_recipe "openssh" # Will enable password based logins
include_recipe "nscd"

package "ldap-utils" do
  action :upgrade
end

package "libnss-ldap" do
  action :upgrade
end

package "libpam-ldap" do
  action :upgrade
end

ldap_data = Chef::EncryptedDataBagItem.load("passwords", "ldap_server")

template "/etc/ldap.secret" do
  source "ldap.secret.erb"
  owner "root"
  group "root"
  mode 0400
  variables(:ldap_password => ldap_data["password"])
end

template "/etc/ldap.conf" do
  source "ldap.conf.erb"
  owner "root"
  group "root"
  mode 0622
end

cookbook_file "/etc/nsswitch.conf" do
  source "nsswitch.conf"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, resources(:service => "nscd"), :immediately
  notifies :run, resources(:execute => [ "nscd-clear-passwd", "nscd-clear-group" ]), :immediately
end

%w{ account auth password session }.each do |pam|
  cookbook_file "/etc/pam.d/common-#{pam}" do
    source "common-#{pam}"
    mode 0644
    owner "root"
    group "root"
    notifies :restart, resources(:service => "ssh"), :delayed
  end
end

cookbook_file "/etc/security/group.conf" do
  source "group.conf"
  owner "root"
  group "root"
  mode 644
end

