# ubuntu-trusty64-docker

Docker-compatible Vagrant base boxes

## Requirement
   
   1. [VirtualBox](https://www.virtualbox.org/)
   2. [Vagrant](https://www.vagrantup.com/)

## Features

- Ubuntu 14.04.x LTS 
- Docker daemon
- Docker Compose

## Usage

```bash
cd /path/to/project
vagrant up
```

## Troubleshooting

如果 `vagrant reload` 出現  "vboxsf" file system is not available...
則需要安裝 `vbguest` plugin

```bash
vagrant plugin install vagrant-vbguest

```
