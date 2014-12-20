
def r_package_installed?(package)
  require "rinruby"
  R.echo(enable=false)
  R.eval "packages = installed.packages()[,1]"
  packages = R.pull "packages"
  return packages.include?(package)
end
