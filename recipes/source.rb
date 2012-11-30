r_version = node['R']['version']
major_version = r_version.split(".").first

url = "#{node['R']['cran_mirror']}/src/base/R-#{major_version}/R-#{r_version}.tar.gz"

# Command to check if we should be installing R or not.
is_installed_command = "R --version | grep -q #{r_version}"

include_recipe "build-essential"
package "gcc-gfortran"

remote_file "#{Chef::Config[:file_cache_path]}/R-#{r_version}.tar.gz" do
  source url
  mode "644"
  checksum node['R']['checksum']
end

execute "Install R from Source" do
  cwd Chef::Config[:file_cache_path]
  command <<-CODE
set -e
tar xvf R-#{r_version}.tar.gz
(
cd #{Chef::Config[:file_cache_path]}/R-#{r_version}
./configure #{node['R']['config_opts'].join(" ")}
make
make install
)
CODE
  not_if is_installed_command
end
