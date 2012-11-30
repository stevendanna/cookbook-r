Description
===========
This cookbook installs and configures R.  It also contains an
R_package provider which can be used in recipes to install R packages
from CRAN.

Requirements
============

* **apt**: Required for APT installation.
* **build-essential**: Required for source installation.

Attributes
==========

* `node['R']['install_method']`: Specifies either "source" or
  "package" install method.

* `node['R']['cran_mirror]`: Used by the Rprofile.site template
to set the system-wide default CRAN mirror.

* `node['R']['version']`: The R version to install.  When using Apt, set
to nil to always get the latest version.

* `node['R']['checksum']`: SHA256-sum of the R source package.

* `node['R']['config_opts]`: Options to pass to R's configure
  script. Source install only.


# Providers


## R_package

The R_package provider can be used to manage packages available in the
CRAN repository.  Currently to use this provider, your default CRAN
mirror must be set.  The default recipe sets this for you.

### Actions

* `:install`: Installs the package from CRAN.  Does nothing if the
  package is already installed. [default]

* `:upgrade`: Upgrades the package to the latest version.  Currently
  this will re-install the package even if it is at the latest
  version.

* `:remove`: Removes the package if it is installed.

## Examples

Install a package:

    R_package "snow"

Remove a package:

    R_package "snow" do
        action :remove
    end


Usage
=====
Add the default recipe to the run_list of a node or role.
