# Shiny Data Management

A problem exists with the standard Shiny + Shiny Server setup.
If the Shiny data is periodically updated and >2 users are browsing the app, they can enter a loop  which will disable them from refreshing data.
This happens because of the Shiny-specific data management and the way Shiny Server works.

## Data

Shiny can store some data "globally". This refers to objects initialised outside the `server()` function. Essentially, if A and B are browsing a Shiny app which is powered by a single R process - then both A and B will be using the same objects. That's the reason for calling them global.

### Why would you want this

This is the faster way to handle large data or some processing which must occur when an app start. You can do it at the first time Shiny Server powers an app and then you're done.
Also, the memory output of the Shiny app will be lower if objects are shared.

### Why wouldn't you?

2 reasons. The first one is that you mustn't modify the shared objects - otherwise you could ruin someone's session. The second reason is that it complicates the architecture - you must ensure that all users have the right and up-to-date data.

## Proof of Concept

Try the simple setup given in this repository. Play with the bottom two `make` directives - the first one functions as you would expect, and the second one doesn't.

Try the following sequence:

* run: `make shiny-server-wo-refresh`
* open the [app](`127.0.0.1/example-app/`) in one browser
* open the [app](`127.0.0.1/example-app/`) in another browser or browser tab
* run: `make data`
* refresh the second tab and look at the Global/Local data
* open app in yet another browser/tab and look at the data
* even close all tabs, reopen the app and then look at the data

After this, repeat the whole procedure starting with `make shiny-server-with-refresh`.


## Solution

### Refresh the data!

To ensure that refreshing the app loads most recent data, every time you update some data files also do `touch refresh.txt` in the app root directory. This signals to Shiny Server that the R process running the app must be restarted at the next opportunity.

### Shut down an R process without active connections

There's a setting in the `shiny-server.conf` file called `app_idle_timeout`. This is the number of seconds an R process running a shiny app will remain live if it has no active connections.

If you set it to 0, it disables this mechanism - the process is never killed. Even if it's set to 1 (second), it takes a few seconds more.

To get a deeper insight into process management, do the following:

* connect to docker with `docker exec -it <docker_name> /bin/bash`
* install ps with `apt-get update && apt-get install -y procps`
* run `top`
* play with the Shiny apps
