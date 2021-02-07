Sample init scripts and service configuration for dftzd
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/dftzd.service:    systemd service unit configuration
    contrib/init/dftzd.openrc:     OpenRC compatible SysV style init script
    contrib/init/dftzd.openrcconf: OpenRC conf.d file
    contrib/init/dftzd.conf:       Upstart service configuration file
    contrib/init/dftzd.init:       CentOS compatible SysV style init script

1. Service User
---------------------------------

All three Linux startup configurations assume the existence of a "dftzcore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes dftzd will be set up for the current user.

2. Configuration
---------------------------------

At a bare minimum, dftzd requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, dftzd will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that dftzd and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If dftzd is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running dftzd without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/dftz.conf`.

3. Paths
---------------------------------

3a) Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/dftzd`  
Configuration file:  `/etc/dftzcore/dftz.conf`  
Data directory:      `/var/lib/dftzd`  
PID file:            `/var/run/dftzd/dftzd.pid` (OpenRC and Upstart) or `/var/lib/dftzd/dftzd.pid` (systemd)  
Lock file:           `/var/lock/subsys/dftzd` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the dftzcore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
dftzcore user and group.  Access to dftz-cli and other dftzd rpc clients
can then be controlled by group membership.

3b) Mac OS X

Binary:              `/usr/local/bin/dftzd`  
Configuration file:  `~/Library/Application Support/DFTzCore/dftz.conf`  
Data directory:      `~/Library/Application Support/DFTzCore`
Lock file:           `~/Library/Application Support/DFTzCore/.lock`

4. Installing Service Configuration
-----------------------------------

4a) systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start dftzd` and to enable for system startup run
`systemctl enable dftzd`

4b) OpenRC

Rename dftzd.openrc to dftzd and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/dftzd start` and configure it to run on startup with
`rc-update add dftzd`

4c) Upstart (for Debian/Ubuntu based distributions)

Drop dftzd.conf in /etc/init.  Test by running `service dftzd start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

4d) CentOS

Copy dftzd.init to /etc/init.d/dftzd. Test by running `service dftzd start`.

Using this script, you can adjust the path and flags to the dftzd program by
setting the DASHD and FLAGS environment variables in the file
/etc/sysconfig/dftzd. You can also use the DAEMONOPTS environment variable here.

4e) Mac OS X

Copy org.dftz.dftzd.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.dftz.dftzd.plist`.

This Launch Agent will cause dftzd to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run dftzd as the current user.
You will need to modify org.dftz.dftzd.plist if you intend to use it as a
Launch Daemon with a dedicated dftzcore user.

5. Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
