#
# Author:: Steven Danna(<steve@opscode.com>)
# Cookbook Name:: R
# Recipe:: install_package
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

case node['platform_family']
when 'debian'
  package 'r-base' do
    version node['r']['version'] if node['r']['version']
    action :install
  end

  if node['r']['install_dev']
    package 'r-base-dev' do
      version node['r']['version'] if node['r']['version']
      action :install
    end
  end
when 'rhel'
  if node['r']['install_dev']
    package 'R-devel' do
      version node['r']['version'] if node['r']['version']
      action :install
    end
  else
    package 'R' do
      version node['r']['version'] if node['r']['version']
      action :install
    end
  end
end