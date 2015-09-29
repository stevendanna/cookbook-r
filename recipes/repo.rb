#
# Author:: Steven Danna(<steve@opscode.com>)
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com
# Cookbook Name:: R
# Recipe:: repo
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
  include_recipe 'apt'

  case node['platform']
  when 'debian'
    postfix = if node['r']['version'] && node['r']['version'].split('.').first == '2'
                ''
              else
                '3'
              end
    distro_name = "#{node['lsb']['codename']}-cran#{postfix}"
    keyserver_url = 'pgp.mit.edu'
    key_id = '381BA480'
  when 'ubuntu'
    distro_name = node['lsb']['codename']
    keyserver_url = 'keyserver.ubuntu.com'
    key_id = 'E084DAB9'
  else
    return 'platform not supported'
  end

  apt_repository 'cran-apt-repo' do
    uri "#{node['r']['cran_mirror']}/bin/linux/#{node['platform']}"
    distribution "#{distro_name}/"
    components []
    keyserver keyserver_url
    key key_id
    action :add
  end
end
