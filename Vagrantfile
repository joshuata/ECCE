# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    # config.vm.box = "ubuntu/xenial64"
    config.vm.box = "generic/ubuntu1604"
    # config.vm.box = "box-cutter/ubuntu1604-desktop"

    config.vm.provision :shell, path: "build/provision.sh"

    config.vm.provider "virtualbox" do |v|
      # v.gui = true
      v.customize ["modifyvm", :id, "--accelerate3d", "on"]
      v.customize ["modifyvm", :id, "--vrde", "off"]
      config.ssh.forward_x11 = true
    end

    if Vagrant.has_plugin?("vagrant-vbguest")
        config.vbguest.auto_update = false
    end

    port = 22000
    config.vm.network "forwarded_port", id: "ssh", host: port, guest: 22, auto_correct: false
    config.vm.synced_folder ".ccache", "/home/vagrant/.ccache", create: true


    clion = true
    if clion
        config.vm.post_up_message = "CLion workarounds enabled"

        # CLion relies on a fixed SSH address, so assign static SSH port here. This
        # must be unique on the host machine.
        config.vm.post_up_message += "\nUse port #{port} for CLion remote host connection"

        # CLion only supports SFTP deployments for remote development, so disable
        # folder syncing and let CLion manage the project directory. This means
        # that the contents of the project directory cannot be relied upon while
        # provisioning the VM.
        remote = "/vagrant"
        config.vm.post_up_message += "\nUse #{remote} as the remote deployment directory"
        config.vm.synced_folder ".", remote, disabled: true
        config.vm.provision :shell, inline: "sudo sh -c '(mkdir #{remote} 2>/dev/null && chown vagrant:vagrant #{remote}) || true'"
    end
end
