#
# Author:: Steven Danna(<steve@opscode.com>)
# Cookbook Name:: R
# Recipe:: default
#
# Copyright 2011, Opscode, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

r_version = node['R']['version']

case node['platform']
when "ubuntu", "debian"
  # On Ubuntu or Debian we install via the
  # CRAN apt repository.
  include_recipe "apt"

  # Apt installs R here.  Needed for config template below
  r_install_dir = "/usr/lib/R"

  distro_name = if node['platform'] == 'debian'
                  "#{node['lsb']['codename']}-cran/"
                else
                  "#{node['lsb']['codename']}/"
                end

  apt_repository "cran-apt-repo" do
    uri "#{node['R']['cran_mirror']}/bin/linux/#{node['platform']}"
    distribution distro_name
    keyserver "keyserver.ubuntu.com"
    key "E084DAB9"
    action :add
  end

  package 'r-base' do
    version r_version
    action :install
  end

  package 'r-base-dev' do
    version r_version
    action :install
  end
when "centos", "redhat"
  # On CentOs and RHEL we install from source

  major_version = r_version.split(".").first
  url = "#{node['R']['cran_mirror']}/src/base/R-#{major_version}/R-#{r_version}.tar.gz"

  # By default, source install places R here.
  # Needed for config template below
  r_install_dir = if node['kernel']['machine'] == 'x86_64'
                    "/usr/local/lib64/R"
                  else
                    "/usr/local/lib/R"
                  end

  # Command to check if we should be installing R
  # or not.
  is_installed_command = "R --version | grep -q #{r_version}"

  include_recipe "build-essential"
  package "gcc-gfortran"


  remote_file "/tmp/R-#{r_version}.tar.gz" do
    source url
    mode "644"
    not_if is_installed_command
    action :create_if_missing
  end

  execute "Install R from Source" do
    cwd "/tmp"
command <<-CODE
set -e
tar xvf R-#{r_version}.tar.gz
(cd /tmp/R-#{r_version} && ./configure #{node['R']['config_opts'].join(" ")})
(cd /tmp/R-#{r_version} && make)
(cd /tmp/R-#{r_version} && make install)
CODE
    not_if is_installed_command
  end
else
  Chef::Log.info("This cookbook is not yet supported on #{node['platform']}")
end

# Setting the default CRAN mirror makes
# remote administration of R much easier.
template "#{r_install_dir}/etc/Rprofile.site" do
  mode "777"
  variables( :cran_mirror => node['R']['cran_mirror'])
end
