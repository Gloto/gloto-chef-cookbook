
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
