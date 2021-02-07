#!/bin/bash
# use testnet settings,  if you need mainnet,  use ~/.dftzcore/dftzd.pid file instead
dftz_pid=$(<~/.dftzcore/testnet3/dftzd.pid)
sudo gdb -batch -ex "source debug.gdb" dftzd ${dftz_pid}
