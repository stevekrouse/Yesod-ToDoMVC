Yesod-ToDoMVC
=============

A ToDoList in Yesod for the ToDoMVC Project


Yesod Basics
============

First things first, I needed to get a working ToDo app with Javascript logic. To this
effect, I spent much time refactoring the html of the JQuery ToDo app over to Hamlet,
adding remote scripts, and finagling with the JQuery to get it to finally work perfectly.

Fay Trouble
===========

Next, I decided to jump right into Fay, a subset of Haskell that compiles to Javascript,
to refactor more logic into Haskell. I ran into a few complications, however, as Fay doesn't
support TemplateHaskell (and thus Hamlet), nor does it play nicely with Handlebar templates
(spent a few hours trying to encode and decode JSON, with single quotes here and double quotes
there all to no avail). Eventually, I was forced to hardcode the templates myself.

Fay Proof-Of-Concept
====================

I don't have enough time now to refactor our all of the todo persistance, editing and display
logic. However, as a proof-of-concept, I refactored out all of the logic of the "renderFooter"
function of the JQuery ToDoMVC example into fay.hs. And then I replaced all calls to renderFooter
in homepage.julis with calls to my new fay code, "main._(main.Test_Fay$main)". Not so pretty, but
it works.

NOTES
=====

I played around with sessions a bit, but didn't get a chance to put the knowledge to work.
However, I left the code in place, just commented out to see my progess.

Also, I wasn't able to figure out how to reference local javascript files (that aren't widget-ed julius)
so I just hosted my compiled fay.js file on cloud.app and referenced it remotely (as my main-man Michael
Snoyman reccomends).