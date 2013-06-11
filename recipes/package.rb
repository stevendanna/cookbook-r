#
# Author:: Steven Danna(<steve@opscode.com>)
# Cookbook Name:: R
# Recipe:: package
#
# Copyright 2011-2013, Steven S. Danna (<steve@opscode.com>)
# Copyright 2013, Mark Van de Vyver (<mark@taqtiqa.com>)
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

# On Ubuntu or Debian we install via the
# CRAN apt repository.
include_recipe "apt"

r_version = node['r']['version']

if node['platform'] == 'debian'
  distro_name = "#{node['lsb']['codename']}-cran/"
  keyserver_url = "pgp.mit.edu"
  key_id = "381BA480"
else
  distro_name = "#{node['lsb']['codename']}/"
  keyserver_url = "keyserver.ubuntu.com"
  key_id = "E084DAB9"
end

apt_repository "cran-apt-repo" do
  uri "#{node['r']['cran_mirror']}/bin/linux/#{node['platform']}"
  distribution distro_name
  keyserver keyserver_url
  key key_id
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
