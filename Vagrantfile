# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 7777, host: 7777

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.13.2"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/home/ubuntu/valadoc-org"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    add-apt-repository --yes ppa:vala-team
    apt-get update -y
    apt-get install -y         \
        git                    \
        libgee-0.8-dev         \
        libgirepository1.0-dev \
        libglib2.0-dev         \
        libjson-glib-dev       \
        libmysqlclient-dev     \
        libsoup2.4-dev         \
        libvaladoc-dev         \
        python3-pip            \
        sphinxsearch           \
        unzip                  \
        valac                  \
        valadoc                \
        xsltproc

    wget -nc https://github.com/ninja-build/ninja/releases/download/v1.6.0/ninja-linux.zip
    unzip ninja-linux.zip -d /usr/local/bin

    pip3 install meson

    cd /home/ubuntu
    rm -rf valum-0.3.6
    wget -nc https://github.com/valum-framework/valum/archive/v0.3.6.zip
    unzip v0.3.6.zip
    cd /home/ubuntu/valum-0.3.6
    mkdir build
    meson --prefix=/usr --buildtype=release build
    ninja -C build
    ninja -C build test
    ninja -C build install

    cd /home/ubuntu
    rm -rf compose-master
    wget -O compose-master.zip https://github.com/arteymix/compose/archive/master.zip
    unzip compose-master.zip
    cd /home/ubuntu/compose-master
    mkdir build
    meson --prefix=/usr --buildtype=release build
    ninja -C build
    ninja -C build test
    ninja -C build install

    cd /home/ubuntu/valadoc-org
    make clean
    make
    make build-docs
    rm -rf sphinx/storage
    mkdir sphinx/storage
    ./configgen valadoc.org
    indexer --config sphinx.conf --all
  SHELL
end
