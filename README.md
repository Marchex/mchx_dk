# mchx_dk

This is the development kit for doing Chef development at Marchex.  It installs the [Chef Development Kit](https://github.com/chef/chef-dk) from Chef, along with supporting system packages as necessary, in default system locations.  The Marchex-specific portions of the kit will be placed in one directory on your workstation (default is `$HOME/marchex-chef`).

It will prepare your workstation for working with cookbooks: creating, writing, modifying, and testing them.


## Create User Accounts

To use mchx_dk you need accounts on Marchex's [Chef](https://chef.marchex.com/), [Delivery](https://delivery.marchex.com/), [GitHub](https://github.marchex.com/).

* Log in to [GitHub](https://github.marchex.com/) to create your account (see the [GitHub wiki page](http://wiki.marchex.com/index.php/GitHub#Access) for more information)
* Set up your GitHub API token
* Go to [Chef](https://chef.marchex.com/) and sign in with your LDAP username and password to create your account, and select the option to Link your account
* Ask the [Tools team](mailto:tools-team@marchex.com?subject=Please%20set%20up%20my%20Chef%20and%20Delivery%20accounts) to set up your Chef and Delivery accounts.
  * **TOOLS TEAM ONLY**: create the user's account in the Delivery UI (as an "LDAP" user with "admin" role) and then run `setup_chef_user.sh $USER` (from the [chef-utils repo](https://github.marchex.com/marchex-chef/chef-utils/)) to finalize setting their accounts up.


## Get Client Key

If you do not already have a client key for the in-house Chef server, you will need to either get your key migrated from the old server, or create a new one if you don't have an old one.

* To migrate it, ask the [Tools team](mailto:tools-team@marchex.com?subject=Please%20migrate%20my%20Chef%20key) that you want it migrated, and tell them what your user name is on the out-house Chef.  Then you can use the same key on both in-house and out-house Chef servers.
  * **TOOLS TEAM ONLY**:  run `migrate_chef_user_key.sh $OUTHOUSE_USER $USER` (from the [chef-utils repo](https://github.marchex.com/marchex-chef/chef-utils/)) to copy their public key from the out-house Chef to the in-house Chef.
* If you do not have a client key, or you need to reset it, you can go into the UI, select your name in the top right, select "My Profile", and then click "Reset Key."  That will generate a new key and give you the new private key file.
* Copy your Chef client key to your workstation at `$HOME/.ssh/$USER.pem` (or wherever you prefer) if you don't already have it there, so you can tell the installer where it lives.


## Install DK

1. If not running a supported Linux (just the Debian/Ubuntu family is supported now), you may need to install some packages yourself:
    * curl
    * vagrant
    * VirtualBox
1. Fetch and run the install script. You will be prompted a few times for paths and passwords. You will only need to re-run the install script if you want to re-install your setup, or update ChefDK.  It has been tested on Ubuntu 12.04, Ubuntu 16.04, and macOS.
    * With curl:
        * `bash <(curl -sL https://github.marchex.com/marchex-chef/mchx_dk/raw/master/install.sh)`
    * With wget:
        * `bash <(wget -qO- https://github.marchex.com/marchex-chef/mchx_dk/raw/master/install.sh)`
    * Or, just fetch [the install script](https://github.marchex.com/marchex-chef/mchx_dk/raw/master/install.sh) and execute it:
        * `bash install.sh`
1. After the script runs, execute `eval "$(chef shell-init bash)"` to load the chef DK into your environment.  Add this to your `.bash_profile` if you want it run for you when you log in.  (If not using `bash`, adjust accordingly.)
