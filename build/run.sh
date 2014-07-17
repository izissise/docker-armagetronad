#!/bin/bash

USERNAME="armagetronad"

chown $USERNAME:$USERNAME /home/$USERNAME/ -R
sudo -s -u $USERNAME . srv.sh