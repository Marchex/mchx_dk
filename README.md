# mchx_dk

This is the development kit for doing Chef development at Marchex.  It installs the latest stable release of the [Chef Development Kit](https://github.com/chef/chef-dk) from Chef, along with supporting system packages as necessary, in default system locations.  The Marchex-specific portions of the kit will be placed in one directory on your workstation (default is `$HOME/marchex-chef`, but it can be wherever you wish).

It will prepare your workstation for working with cookbooks: creating, writing, modifying, and testing them.

This is for in-house Chef development.  See [Chef on the Marchex wiki](http://wiki.marchex.com/index.php/Chef#Using_Chef) for more information.


## Create User Accounts

To use mchx_dk you first need an account on [GitHub](https://github.marchex.com/).

* Log in to [GitHub](https://github.marchex.com/) to create your account (see the [GitHub wiki page](http://wiki.marchex.com/index.php/GitHub#Access) for more information)
* Ask the [Tools team](mailto:tools-team@marchex.com?subject=Please%20set%20up%20my%20Chef%20account) to set up your Chef account.
  * **TOOLS TEAM ONLY**: run `setup_chef_user.sh $USER` (from the [chef-utils repo](https://github.marchex.com/marchex-chef/chef-utils/)) to finalize setting their accounts up.  If the user is newly created in Chef, send the user the `$USER.pem` file (their new private client key) the script generated.



## Get Client Key

If you do not already have a client key for the in-house Chef server (which may have been generated for you above), you will need to create a new one.  **NOTE**: you will use the same key everywhere you use chef, for both in-house and out-house, and you'll need to place the key and make your knife.rb point to it everywhere you are using knife.

* Ask the [Tools team](mailto:tools-team@marchex.com?subject=Please%20migrate%20my%20Chef%20key) that you want it created.
  * **TOOLS TEAM ONLY**:  run `knife user key create $USER -f $USER.pem -k default` for the given user.  This will create a new default keypair for the user and save the private key in a .pem file named for the user, which you then send to the user.  If the default keypair already exists, delete it first with `knife_ent user key delete $USER default -y`.
* Copy your Chef client key to your workstation at `$HOME/.ssh/$USER.pem` (or wherever you prefer) if you don't already have it there, so you can tell the installer where it lives.


## Install DK

1. If not running a supported Linux (just the Debian/Ubuntu family is supported now), you may need to install some packages yourself:
    * curl
    * vagrant
    * VirtualBox
1. Fetch and run the install script. You will be prompted a few times for paths and passwords. You will only need to re-run the install script if you want to re-install your setup, or update ChefDK.  It has been tested on Ubuntu 12.04, Ubuntu 14.04, Ubuntu 16.04, and macOS.
    * With curl:
        * `bash <(curl -sL https://github.marchex.com/marchex-chef/mchx_dk/raw/master/install.sh)`
    * With wget:
        * `bash <(wget -qO- https://github.marchex.com/marchex-chef/mchx_dk/raw/master/install.sh)`
    * Or, just fetch [the install script](https://github.marchex.com/marchex-chef/mchx_dk/raw/master/install.sh) and execute it:
        * `bash install.sh`
1. After the script runs, execute `eval "$(chef shell-init bash)"` to load the chef DK into your environment.  Add this to your `.bash_profile` if you want it run for you when you log in.  (If not using `bash`, adjust accordingly.)


## Verify Installation

1. `cd` to your new directory `marchex-chef/cookbooks/mchx_dk`.
1. Run `knife user show $USER` to see your own user config from the Chef server.
1. Run `knife environment list | grep delivered` to verify that `delivered` is in the list.  This ensures we are using the correct Chef server.
1. Run `rake unit` to test that the basic tests are working.


## Copyright and license

Code and documentation copyright 2016-2017 [Marchex, Inc.](https://www.marchex.com/) ([GitHub](https://github.com/Marchex)). Code released under the [MIT License](https://github.com/Marchex/mchx_dk/blob/master/LICENSE.txt).
