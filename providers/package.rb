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

action :install do
  execute 'Install R Package' do
    command r_package_install(new_resource.package)
    not_if r_package_is_installed(new_resource.package)
  end
end

action :upgrade do
  execute 'Upgrade R Package' do
    command r_package_install(new_resource.package)
  end
end

action :remove do
  r_package_remove = "remove.packages('#{new_resource.package}')"
  execute 'Remove R Package' do
    command "echo \"#{r_package_remove}\" | R --no-save --no-restore -q"
    only_if r_package_is_installed(new_resource.package)
  end
end


# The following helper functions construct strings that can be run as
# Bash commands. For example, as the input of not_if or only_if
# statements

def r_package_is_installed(package_name)
  r_code = "if (any(installed.packages()[,1] == '#{package_name}')) { quit('no', 0, FALSE) }; quit('no', 1, FALSE)"
  "echo \"#{r_code}\" | R --no-save --no-restore -q"
end

def r_package_install(package_name)
  r_code = "install.packages('#{package_name}')"
  "echo \"#{r_code}\" | R --no-save --no-restore -q"
end
