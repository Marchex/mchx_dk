#!/bin/bash
echo "{\"marchefdk\":{\"basedir\":\"$(cat $HOME/.marchex-chef-basedir)\"}}" | sudo chef-client -z -j /dev/stdin -o 'recipe[marchefdk::zero]' --disable-config
