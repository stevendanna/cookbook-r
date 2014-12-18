name             "r"
maintainer       "Steven Danna"
maintainer_email "steve@opscode.com"
license          "Apache 2.0"
description      "Installs/Configures R"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"

depends "apt"
depends "ark"
depends "build-essential"
depends 'readline'          # in case of future problems: was working with v0.0.3

supports "ubuntu"
supports "centos"
