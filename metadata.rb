name 'marchefdk'
maintainer 'Marchex Engineering'
maintainer_email 'techops@marchex.com'
license 'all_rights'
description 'Installs/Configures marchefdk'
long_description 'Installs/Configures marchefdk'
version '0.1.0'

# Specify version constraint for community cookbooks (not authored by marchex or checked in to https://github.marchex.com/marchex-chef)
# example:
# depends 'apt', '=> 2.9.2' # use 'greater than or equal to' version constraint operator unless you have a good reason not to

# DO NOT specify version constraints for marchex-authored cookbooks, just use 'depends' - version control is provided by delivery
# example:
depends 'mchx_chef_helpers'

issues_url 'https://jira.marchex.com'
source_url 'https://github.marchex.com/marchex-chef/marchefdk'
