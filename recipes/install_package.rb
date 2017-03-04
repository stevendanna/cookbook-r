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

pkg_name = case node['platform_family']
           when 'rhel'
             'R'
           when 'debian'
             'r-base'
           else
             'r_base'
           end

include_recipe 'yum-epel::default' if node['platform_family'] == 'rhel'

package pkg_name do
  version node['r']['version'] if node['r']['version']
  action :install
end

if node['r']['install_dev'] # ~FC023
  package 'r-base-dev' do
    version node['r']['version'] if node['r']['version']
    action :install
  end
end
