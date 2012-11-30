#
# Author:: Steven Danna(<steve@opscode.com>)
# Cookbook Name:: R
# Attribute:: default
#
# Copyright 2011, Steven S. Danna (<steve@opscode.com>)
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

default['R']['cran_mirror'] = "http://cran.fhcrc.org/"

case node['platform_family']
when 'debian'
  default['R']['version'] = nil
  default['R']['install_method'] = 'package'
else
  default['R']['version'] = '2.15.2'
  default['R']['install_method'] = 'package'
  default['R']['config_opts'] = [ "--with-x=no" ]
end
