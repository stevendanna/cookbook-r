
def package_installed?(package)
  require "rinruby"

  R.eval "packages = installed.packages()[,1]"
  packages = R.pull "packages"
  return packages.include?(package)
end
