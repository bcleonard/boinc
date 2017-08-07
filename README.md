# boinc

This container will run the boinc_client.  It is built so that you can host all the project data external to the container, allowing you run the client on a host and have persistant data.

### Preperation
Before running the container, you'll need to have the following directories predefined on the container host:
```sh
boinc
```
It will also need to be owned or read/writable by the user/group root as the boinc_client runs as root in the container.  The boinc directory will hold all of your boinc data and make persistant.  I used:
```sh
/data/boinc
```
for the instructions below.  Just make sure you create it prior to starting the container.
### Running:
```sh
docker run --name=boinc -h HOSTNAME -p 31416 -v /data/boinc:/var/lib/boinc-client bcleonard/boinc 
```
Please see the Notes/Caveats/Issues below for more information.
### Configuration:
As I said before, /data/boinc will hold all of your project data.  You can prepopulate any files you need or let the client initialize it for you.
You will need to configure the boinc_client before it can do any actual work.  I recommend running the following:
```sh
docker exec boinc boinccmd --join_acct_mgr URL name passwd
```
which will attach the client to an account manager.  This should initialize the client so it starts doing work.

For example, to link the container to boincstats:
```sh
docker exec boinc boinccmd --join_acct_mgr http://bam.boincstats.com <username> <password>
```
### Additional Configuration:
Since docker now has the exec command, you can now run commands inside the container.  For this container, you can run the boinccmd and use it to configure the boinc_client.  The following syntax works:
```sh
decker exec boinc boinccmd <boinccmd arguements>
```
Running the above command without any boinccmd arguements will show you what arguments you can use.  For example, to get the state of the boinc client:
```sh
docker exec boinc boinccmd --get_state
```
### Notes/Caveats/Issues:
1.	-h HOSTNAME - I recommend that you use this option (choose your own hostname) so that your host id for boinc is not the container id.
2.	I have installed the 32 bit binaries so that projects such as climateprediction will run.  However, for some reason, the boinc_client doesn't see them, so 32 bit projects won't run.  The same libraries work outside of a container, so I'm not sure whats going on.  Its low on my list, but if somebody can point me in the right direction, I'd be grateful.
3.	No GUI password.  By default, I set a blank password.  You can change this by prepopulating /data/boinc/gui_rpc_auth.cfg.  If somebody asks, I update the script to generate a randon password on initial startup.
4.	After starting, I had to manually tell the client to start downloading work.  I'm not sure why I had to do that, but I waited almost 8 hours and it still hadn't downloaded any work.  After doing that, the work downloaded and it started doing work.
