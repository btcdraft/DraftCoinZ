
Debian
====================
This directory contains files used to package dftzd/dftz-qt
for Debian-based Linux systems. If you compile dftzd/dftz-qt yourself, there are some useful files here.

## dftz: URI support ##


dftz-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install dftz-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your dftz-qt binary to `/usr/bin`
and the `../../share/pixmaps/dftz128.png` to `/usr/share/pixmaps`

dftz-qt.protocol (KDE)

