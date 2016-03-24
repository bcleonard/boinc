#!/bin/sh

if [ ! -f /var/lib/boinc/gui_rpc_auth.cfg ]
then
  touch /var/lib/boinc/gui_rpc_auth.cfg
fi

boinc_client --dir /var/lib/boinc --allow_remote_gui_rpc
