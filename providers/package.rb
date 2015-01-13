#
# Author:: Steven Danna(<steve@opscode.com>)
# Cookbook Name:: R
# Recipe:: package
#
# Copyright 2011-2013, Steven S. Danna (<steve@opscode.com>)
# Copyright 2013, Mark Van de Vyver (<mark@taqtiqa.com>)#
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

# Support whyrun
def whyrun_supported?
  true
end

action :install do
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource.name } already exists - nothing to do."
  else
    converge_by("Create #{ @new_resource.name }") do
      install_package
    end
  end
end

action :upgrade do
  converge_by("Create #{ @new_resource.name }") do
    install_package
  end
end

action :remove do
  if @current_resource.exists
    converge_by("Remove #{ @new_resource.name }") do
      remove_package
    end
  else
    Chef::Log.info "#{ @new_resource.name } doesn't exists - nothing to do."
  end
end

def load_current_resource
  @current_resource = Chef::Resource::RPackage.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.package(@new_resource.package)
  if package_installed?(@current_resource.package)
    @current_resource.exists = true
  end
end

def install_package
  require "rinruby"
  R.eval "install.packages('#{new_resource.package}')", false
end

def remove_package
  require "rinruby"
  R.eval "remove.packages('#{new_resource.package}')", false
end
