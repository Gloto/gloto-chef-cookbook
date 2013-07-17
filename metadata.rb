name             "gloto-chef-cookbook"
maintainer       "Gloto Corp."
maintainer_email "support@gloto.com"
license          "All rights reserved"
description      "Collection of recipes for setting up Gloto's servers"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.1.1"
recipe           "gloto-chef-cookbook", "Empty. Use another recipe."
recipe           "gloto-chef-cookbook::apt-update", "Run apt-get update if it has been a while."
recipe           "gloto-chef-cookbook::ldap-client", "Set up LDAP+PAM authentication"

supports "ubuntu"
supports "debian"

depends "openssh"
depends "nscd"
