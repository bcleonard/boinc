#!/bin/sh

if [ ! -f /var/lib/boinc/gui_rpc_auth.cfg ]
then
  touch /var/lib/boinc/gui_rpc_auth.cfg
fi

/usr/bin/boinc --dir /var/lib/boinc-client --allow_remote_gui_rpc
