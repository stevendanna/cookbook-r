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

chef_gem "rinruby"

if node['r']['install_repo']
  include_recipe "r::repo"
end

include_recipe "r::install_#{node['r']['install_method']}"


# Creating /etc/ folder in installation directory if not existing before (preventing potential directory not found errors)
# Note: Only directories that did not exist before will be assigned to the given user, in this case: root
directory node['r']['install_dir'] + '/etc' do
  owner 'root'
  group 'root'
  recursive true
end

# Setting the default CRAN mirror makes
# remote administration of R much easier.
template "#{node['r']['install_dir']}/etc/Rprofile.site" do
  mode "0555"
  variables( :cran_mirror => node['r']['cran_mirror'])
end
