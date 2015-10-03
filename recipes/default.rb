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

chef_gem 'rinruby' do
  compile_time false if respond_to?(:compile_time)
end

include_recipe 'r::repo' if node['r']['install_repo']

include_recipe "r::install_#{node['r']['install_method']}"

directory node['r']['install_dir'] + '/etc' do
  owner 'root'
  group 'root'
  recursive true
end

# Setting the default CRAN mirror makes
# remote administration of R much easier.
template "#{node['r']['install_dir']}/etc/Rprofile.site" do
  mode '0555'
  variables(cran_mirror: node['r']['cran_mirror'])
  manage_symlink_source true if respond_to?(:manage_symlink_source)
end
