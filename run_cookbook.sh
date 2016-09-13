#!/bin/bash
echo "{\"mchx_dk\":{\"basedir\":\"$(cat $HOME/.marchex-chef-basedir)\"}}" | sudo chef-client -z -j /dev/stdin -o 'recipe[mchx_dk::zero]' --disable-config
