source 'https://supermarket.marchex.com'
source 'https://supermarket.chef.io'

metadata

group :integration do
  # Only pull these in for Test Kitchen
  cookbook 'set_hostname'
  cookbook 'pop_prod_sad'
  cookbook 'pop_prod_aws_us_west_2_vpc2'
  cookbook 'sudo'
end

solver :ruby, :required

cookbook 'chef-dk', '~> 3.1.0'
