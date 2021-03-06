name 'mchx_dk'
maintainer 'Marchex Tools'
maintainer_email 'tools-team@marchex.com'
license 'All Rights Reserved'
description 'Installs/Configures mchx_dk'
long_description 'Installs/Configures mchx_dk'
version '0.1.56'

chef_version '~> 12.0'
supports 'ubuntu', '>= 12.04'
supports 'centos', '>= 6.6'

issues_url 'https://jira.marchex.com'
source_url 'https://github.marchex.com/marchex-chef/mchx_dk'

# we want this to be a standalone cookbook, so no dependencies unless necessary
# to install chef-dk, this is necessary
depends 'chef-dk', '~> 3.1.0'

# for our installs recipe
depends 'apt'
