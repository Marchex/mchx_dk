#!/bin/bash

# make sure we're in the right directory (from marchex-chef/cookbooks/mchx_dk/, should be in marchex-chef)
cd $(dirname $0)/../..
dk_basedir=$(cat $HOME/.marchex-chef-basedir)
dk_user=$USER
dk_client_key=$(cat $HOME/.marchex-chef-client-key)

sudo dk_basedir="$dk_basedir" dk_user="$USER" dk_client_key="$dk_client_key" bash -c '
    # set correct env
    eval "$(chef shell-init bash)" &&
    # pass attributes to chef-client in JSON
    (echo "{\"mchx_dk\":{\"basedir\":\"$dk_basedir\",\"client_key\":\"$dk_client_key\",\"user\":\"$dk_user\"}}" |
    # run chef-client in local mode, read JSON attributes, run zero recipe
    chef-client -z -j /dev/stdin -o recipe[mchx_dk::zero] --disable-config)
'
