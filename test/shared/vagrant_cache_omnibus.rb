# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # enable cachier globally
  if !ENV["GLOBAL_VAGRANT_CACHIER_DISABLED"] && Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.auto_detect = true

    if Vagrant.has_plugin?("vagrant-omnibus")
      config.omnibus.cache_packages = true
    end

    # cache bussers, but only if we detect a test-kitchen run
    # see https://github.com/tknerr/bills-kitchen/pull/78
    if Dir.pwd.include? ".kitchen/kitchen-vagrant/"

      config.cache.enable :generic,
                          # for test-kitchen =< 1.3
                          "busser-gemcache"   => { cache_dir: "/tmp/busser/gems/cache" },
                          # for test-kitchen >= 1.4
                          "verifier-gemcache" => { cache_dir: "/tmp/verifier/gems/cache" }

      # fix permissions
      # see https://github.com/mitchellh/vagrant/issues/2257
      # see https://github.com/test-kitchen/test-kitchen/issues/671
      config.vm.provision "shell", inline: <<-EOF
        chown -R vagrant:vagrant /tmp/busser
        chown -R vagrant:vagrant /tmp/verifier
      EOF
    end
  end
end
