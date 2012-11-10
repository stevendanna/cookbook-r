# On Ubuntu or Debian we install via the
# CRAN apt repository.
include_recipe "apt"

r_version = node['R']['version']

# Apt installs R here.  Needed for config template below
r_install_dir = "/usr/lib/R"

if node['platform'] == 'debian'
  distro_name = "#{node['lsb']['codename']}-cran/"
  keyserver_url = "pgp.mit.edu"
  key_id = "381BA480"
else
  distro_name = "#{node['lsb']['codename']}/"
  keyserver_url = "keyserver.ubuntu.com"
  key_id = "E084DAB9"
end

apt_repository "cran-apt-repo" do
  uri "#{node['R']['cran_mirror']}/bin/linux/#{node['platform']}"
  distribution distro_name
  keyserver keyserver_url
  key key_id
  action :add
end

package 'r-base' do
  version r_version
  action :install
end

package 'r-base-dev' do
  version r_version
  action :install
end
