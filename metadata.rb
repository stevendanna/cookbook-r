name             "r"
maintainer       "NativeX"
maintainer_email "adrian.herrera@nativex.com"
license          "Apache 2.0"
description      "Installs/Configures R"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"

depends "apt"
depends "ark"
depends "build-essential"
depends "java"

supports "ubuntu"
supports "centos"
