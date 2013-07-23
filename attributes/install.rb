include_attribute "r"


case node['r']['install_method']
when "package"
  default['r']['install_dir'] = "/usr/lib/R"
when "source"
  default['r']['install_dir'] = node['kernel']['machine'] == 'x86_64' ? "/usr/local/lib64/R" : "/usr/local/lib/R"
end
