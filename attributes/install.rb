include_attribute "r"

if node['r']['install_method'] == 'package' and node['platform_family'] == 'debian'
  default['r']['install_dir'] = "/usr/lib/R"
else
  default['r']['install_dir'] = node['kernel']['machine'] == 'x86_64' ? "/usr/local/lib64/R" : "/usr/local/lib/R"
end
