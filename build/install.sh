 #!/bin/bash

USER="armagetronad"
# Create user
useradd -d /home/${USER} -m ${USER}

	# Basic Info
	PREFIX="/home/${USER}/armagetronad"
	
	# Go to Home Dir
	cd /home/$USER
	
	# Install Required Packages
	apt-get update
	apt-get -y --ignore-missing install build-essential automake libboost-dev libxml2-dev bison pkg-config autoconf autotools-dev libprotobuf-dev sudo perl-base
	apt-get -y --no-install-recommends install bzr
	
	# Download the Server
	sudo -u $USER bzr branch lp:~armagetronad-ap/armagetronad/0.2.9-armagetronad-sty+ct+ap
	
	# Enter Server BZR Dir
	cd 0.2.9-armagetronad-sty+ct+ap
	
	# Create Destination Dir
	sudo -u $USER mkdir $PREFIX
	
	# Configure the Server
	sudo -u $USER ./bootstrap.sh
	sudo -u $USER ./configure --prefix=$PREFIX --disable-glout --enable-authentication --disable-sysinstall --disable-useradd --disable-etc --disable-desktop --disable-uninstall
	
	# Build & Install
	sudo -u $USER make
	sudo -u $USER make install
	
	# Mod Permission of Bin to 755 (rwxr-xr-x)
	chmod 755 $PREFIX/bin
	
	# Remove Leftovers
	rm -Rv /home/$USER/0.2.9-armagetronad-sty+ct+ap
	
	apt-get -y remove build-essential automake bzr pkg-config autoconf autotools-dev bison
	apt-get -y autoremove

