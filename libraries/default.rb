def r_package_installed?(package)
  require 'rinruby'
  r = RinRuby.new(echo: false)
  r.eval 'packages = installed.packages()[,1]'
  packages = r.pull 'packages'
  packages.include?(package)
end
