#
# Author:: Steven Danna(<steve@opscode.com>)
# Cookbook Name:: R
# Attribute:: default
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

default['r']['cran_mirror'] = 'http://cran.fhcrc.org/'

case node['platform_family']
when 'debian', 'rhel'
  default['r']['install_method'] = 'package'
  default['r']['install_repo']   = true
else
  default['r']['version']        = '3.0.1'
  default['r']['checksum']       = 'af90488af3141103b211dc81b6f17d1f0faf4f17684c579a32dfeb25d0d87134'
  default['r']['install_method'] = 'source'
  default['r']['config_opts']    = ['--with-x=no']
end

default['r']['install_dev'] = case node['platform_family']
                              when 'rhel'
                                false
                              else
                                true
                              end
