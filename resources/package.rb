#
# Author:: Steven Danna (<steve@opscode.com>)
# Cookbook Name:: R
# Provider:: package
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

# Support whyrun
def whyrun_supported?
  true
end

actions :install, :remove, :upgrade
default_action :install

attribute :package, kind_of: String, name_attribute: true
attribute :exists, kind_of: [TrueClass, FalseClass]

def load_current_value
  exists r_package_installed?(package)
end

def initialize(*args)
  super
  @action = :install
end

action :install do
  if exists
    Chef::Log.info "#{package} already exists - nothing to do."
  else
    converge_by("Create #{package}") do
      install_package
    end
  end
end

action :upgrade do
  converge_by("Create #{package}") do
    install_package
  end
end

action :remove do
  if exists
    converge_by("Remove #{package}") do
      remove_package
    end
  else
    Chef::Log.info "#{package} doesn't exists - nothing to do."
  end
end


def install_package
  require 'rinruby'
  R.eval "install.packages('#{package}')", false
end

def remove_package
  require 'rinruby'
  R.eval "remove.packages('#{package}')", false
end
