#
# Author:: Steven Danna(<steve@opscode.com>)
# Cookbook Name:: R
# Recipe:: default
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

r_version = node['r']['version']
major_version = r_version.split(".").first

url = "#{node['r']['cran_mirror']}/src/base/R-#{major_version}/R-#{r_version}.tar.gz"

# Command to check if we should be installing R or not.
is_installed_command = "R --version | grep -q #{r_version}"

include_recipe "build-essential"
package "gcc-gfortran"

remote_file "#{Chef::Config[:file_cache_path]}/R-#{r_version}.tar.gz" do
  source url
  mode "644"
  checksum node['r']['checksum']
end

execute "Install R from Source" do
  cwd Chef::Config[:file_cache_path]
  command <<-CODE
set -e
tar xvf R-#{r_version}.tar.gz
(
cd #{Chef::Config[:file_cache_path]}/R-#{r_version}
./configure #{node['r']['config_opts'].join(" ")}
make
make install
)
CODE
  not_if is_installed_command
end
