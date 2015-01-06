# Team City 9 out of the box #

This is a Maven project, which results in ZIP-archive with **Vagrant project**.
The Vagrant project

* creates **VM with Centos 7.0**
* installs Docker
* pull necessary images and starts **Docker containers** with
    * mySQL database
    * TeamCity 9 build server
    * 2 TeamCity agents

The created Centos VM and installed Docker repeat your network proxy settings. Therefore you can use the project behind the company firewall

**Final result**: Ready for use TeamCity build server becomes available on your machine at [http://localhost:8112/](http://localhost:8112/)

### How to use it? ###

**Build Maven project**

Get sources from GitHub and run Maven

<pre>
git clone https://github.com/JV-ration/teamcity-farm.git
cd teamcity-farm
mvn clean package
</pre>

The lines above will prepare ZIP file with Vagrant project in target folder

<code>
mvn clean pre-integration-test -Prun-its
</code>

The line above will even unpack the ZIP in target/its/team-city-farm-0.0.1-SNAPSHOT folder

**Create and run VM**

Unzip the archive and change to that directory
Run the command below to create VM and prepare the build server

<code>
bin/vagrant/vagrant-up.sh vagrant.lck
</code>

**Finish configuration of the build server**

When VM is fully provisioned

* open the build server at [http://localhost:8112/](http://localhost:8112/)
* accept JetBrains TeamCity license
* enter the desired administrator name and password
* authorize both agents

### What to expect shortly? ###

* Directly downloadable **Vagrant project**, so you don't have to install and run Maven
* Scripts for running **Docker containers** directly on your machine, so don't have use Vagrant and Virtual Box
* Whatever is seen the project [issues](https://github.com/JV-ration/teamcity-farm/issues)

### Pre-required software ###

* Recent JDK
* Maven 3.0.4 or higher
* Vagrant for managing virtual machine with
* Virtual Box (or another virtualization provider)

### Who do I talk to? ###

* Viktor Sadovnikov [@sadovnikov](https://twitter.com/sadovnikov)
