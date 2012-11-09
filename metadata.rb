maintainer       "Steven Danna"
maintainer_email "steve@opscode.com"
license          "Apache 2.0"
description      "Installs/Configures R"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.0"

depends "apt"
depends "build-essential"

supports "ubuntu"
supports "centos"
