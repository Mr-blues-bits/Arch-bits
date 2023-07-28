#!/bin/bash

echo "Arch Root Changed to Installation"
echo #
echo "Enabling Network Manager:..."
systemctl enable NetworkManager
echo "Enabling Avhil Service:..."
systemctl enable avahi-daemon
