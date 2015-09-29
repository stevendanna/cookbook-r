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
major_version = r_version.split('.').first

# Command to check if we should be installing R or not.
is_installed_command = "R --version | grep -q #{r_version}"

package 'gcc-gfortran'

include_recipe 'build-essential'
include_recipe 'ark'

# required unless "--with-readline=no" is used
include_recipe 'readline'

ark "R-#{r_version}" do
  url "#{node['r']['cran_mirror']}/src/base/R-#{major_version}/R-#{r_version}.tar.gz"
  autoconf_opts node['r']['config_opts'] if node['r']['config_opts']
  action [:install_with_make]
  not_if is_installed_command
end
