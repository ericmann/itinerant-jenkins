Itinerant Jenkins
=================

The entire point of this project is to provide a throwaway provisioner for a Jenkins job server. The Vagrantfile is built to provision an Ubuntu 14.04 machine on either Hyper-V (Windows) or VirtualBox (Mac/Linux). The provisioner then proxies to an inside-the-VM Ansible installation to configure everything else.

Ansible is used internally for two reasons:

1. To allow Windows hosts to share in the Ansible-provisioning love
1. To empower developers who want to use the _same_ provisioning script on a production machine somewhere in the cloud

## Requirements

An optional requirement is to install the [vagrant-ghost](https://github.com/10up/vagrant-ghost) plugin to allow Vagrant to manage your hostsfile for you:

    vagrant plugin install vagrant-ghost

If you forgo this plugin, you'll need to manually update your hosts file to point `jenkins.dev` at your new VM.

## What you get

- Ubuntu 14.04
- Java 8
- Jenkins
- PHP 5.6 (CLI)
- Composer (for package management)
- PHPUnit (for project tests)

Once `vagrant up` has finished doing it's thing, you can access Jenkins at http://jenkins.dev:8080.

## Thanks

- [10up](http://10up.com) for Ansible provisioning inspiration
- [Digital Ocean](https://www.digitalocean.com) for Jenkins installation how-tos

## Release History

 * 2015-04-09   v1.1.0   Add plugins and XDebug support
 * 2015-03-23   v1.0.0   Initial release
