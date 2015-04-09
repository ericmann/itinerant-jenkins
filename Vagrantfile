# -*- mode: ruby -*-
# vi: set ft=ruby :

dir = Dir.pwd
vagrant_dir = File.expand_path(File.dirname(__FILE__))

# Map any directores we need into the VM
FileUtils.mkdir_p( vagrant_dir + '/logs' )

Vagrant.configure("2") do |config|

  # Store the current version of Vagrant for use in conditionals when dealing
  # with possible backward compatible issues.
  vagrant_version = Vagrant::VERSION.sub(/^v/, '')

  # Custom details for Virtualbox if using it as a provider
  config.vm.provider :virtualbox do |v, override|
    v.customize ["modifyvm", :id, "--memory", 512]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

    # Default Box IP Address
    #
    # This is the IP address that your host will communicate to the guest through. In the
    # case of the default `192.168.70.10` that we've provided, VirtualBox will setup another
    # network adapter on your host machine with the IP `192.168.70.1` as a gateway.
    #
    # If you are already on a network using the 192.168.70.x subnet, this should be changed.
    # If you are running more than one VM through VirtualBox, different subnets should be used
    # for those as well. This includes other Vagrant boxes.
    override.vm.network :private_network, ip: "192.168.60.10"

    # Name the vm
    v.name = "Itinerant_Jenkins"
  end

  # Custom details for Hyper-V if using it as a provider
  config.vm.provider :hyperv do |v, override|
    override.vm.network :private_network

    if vagrant_version >= "1.7.3"
      v.memory = 512

      # Name the vm
      v.vmname = "Itinerant_Jenkins"
    end

  end

  # Default Ubuntu Box
  config.vm.box = "ericmann/trusty64"

  # Default Hostname
  config.vm.hostname = "itinerant-jenkins"

  # Local Machine Hosts
  #
  # If the Vagrant plugin Ghost (https://github.com/10up/vagrant-ghost) is
  # installed, the following will automatically configure your local machine's hosts file to
  # be aware of the domains specified below. Watch the provisioning script as you may need to
  # enter a password for Vagrant to access your hosts file.
  if defined?(VagrantPlugins::Ghost)
    # Pass the found host names to the Ghost plugin so it can perform magic.
    config.ghost.hosts = ['jenkins.dev']
  end

  # Forward Agent
  #
  # Enable agent forwarding on vagrant ssh commands. This allows you to use ssh keys
  # on your host machine inside the guest. See the manual for `ssh-add`.
  config.ssh.forward_agent = true

  # Drive mapping
  #
  # The following config.vm.synced_folder settings will map directories in your Vagrant
  # virtual machine to directories on your local machine. Once these are mapped, any
  # changes made to the files in these directories will affect both the local and virtual
  # machine versions. Think of it as two different ways to access the same file. When the
  # virtual machine is destroyed with `vagrant destroy`, your files will remain in your local
  # environment.
  config.vm.synced_folder "logs", "/srv/logs", owner: "www-data", group: "www-data"

  # Customfile - POSSIBLY UNSTABLE
  #
  # Use this to insert your own (and possibly rewrite) Vagrant config lines. Helpful
  # for mapping additional drives. If a file 'Customfile' exists in the same directory
  # as this Vagrantfile, it will be evaluated as ruby inline as it loads.
  #
  # Note that if you find yourself using a Customfile for anything crazy or specifying
  # different provisioning, then you may want to consider a new Vagrantfile entirely.
  if File.exists?(File.join(vagrant_dir,'Customfile')) then
    eval(IO.read(File.join(vagrant_dir,'Customfile')), binding)
  end

  # Ansible Provisioning
  #
  # Actually, we're using shell provisioning to proxy to Ansible so things work reliably across operating systems.
  config.vm.provision :shell do |s|
    s.path = "bin/provision.sh"
  end

end
