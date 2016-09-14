#!/bin/bash

# make sure we're in the right directory (from marchex-chef/cookbooks/mchx_dk/, should be in marchex-chef)
cd $(dirname $0)/../..

sudo bash -c '
    # set correct env
    eval "$(chef shell-init bash)" &&
    # pass attributes to chef-client in JSON
    (echo "{\"mchx_dk\":{\"basedir\":\"$(cat $HOME/.marchex-chef-basedir)\"}}" |
    # run chef-client in local mode, read JSON attributes, run zero recipe
    chef-client -z -j /dev/stdin -o recipe[mchx_dk::zero] --disable-config)
'
