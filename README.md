# mchx_dk

This is the development kit for doing Chef development at Marchex.

1. [Create Chef and Delivery accounts](http://wiki.marchex.com/)
1. Copy your Chef client key to your workstation at `$HOME/.ssh/$USER.pem` (or wherever you prefer)
1. If not running a supported Linux, you may need to install some packages yourself (in particular: curl, vagrant, and VirtualBox).
1. Fetch and run the install script.
  * You will be prompted a few times for paths and passwords.
  * ChefDK will be installed from Chef, along with supporting system packages as necessary, in default system locations.
  * The Marchex-specific portions of the kit will be placed in one directory on your workstation (default is `$HOME/marchex-chef`).
  * You will only need to re-run the install script if you want to re-install your setup, or update ChefDK.
  * Commands:
    * If you have curl:
      * `bash <(curl -sL https://github.marchex.com/marchex-chef/mchx_dk/raw/master/install.sh)`
    * If you have wget:
      * `bash <(wget -qO- https://github.marchex.com/marchex-chef/mchx_dk/raw/master/install.sh)`
    * Otherwise just fetch [the install script](https://github.marchex.com/marchex-chef/mchx_dk/raw/master/install.sh) and run:
      * `bash install.sh`
1. To update your development kit at any time:
```
cd marchex-chef/cookbooks/mchx_dk/
git pull
./run_cookbook.sh # or install.sh to re-run the whole install, including updating ChefDK
```
