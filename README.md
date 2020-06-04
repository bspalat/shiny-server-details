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

The solution is to use a dummy file - `refresh.txt` - which signals to Shiny Server that the R process running the Shiny app must be restarted at the next opportunity.