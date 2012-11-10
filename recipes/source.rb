r_version = node['R']['version']
major_version = r_version.split(".").first

url = "#{node['R']['cran_mirror']}/src/base/R-#{major_version}/R-#{r_version}.tar.gz"

# Command to check if we should be installing R or not.
is_installed_command = "R --version | grep -q #{r_version}"

include_recipe "build-essential"
package "gcc-gfortran"

remote_file "/tmp/R-#{r_version}.tar.gz" do
  source url
  mode "644"
  not_if is_installed_command
  action :create_if_missing
end

execute "Install R from Source" do
  cwd "/tmp"
  command <<-CODE
set -e
tar xvf R-#{r_version}.tar.gz
(cd /tmp/R-#{r_version} && ./configure #{node['R']['config_opts'].join(" ")})
(cd /tmp/R-#{r_version} && make)
(cd /tmp/R-#{r_version} && make install)
CODE
  not_if is_installed_command
end
