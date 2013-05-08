Yesod-ToDoMVC
=============

A [ToDoList](http://f.cl.ly/items/181O1k2f1t3Z0T1n0R06/Screen%20Shot%202013-05-08%20at%2012.25.45%20AM.png) in [Yesod](http://www.yesodweb.com/) for the [ToDoMVC Project](http://todomvc.com/)


* Yesod Basics
  * First things first, I needed to get a working ToDo app with Javascript logic. To this
effect, I spent much time refactoring the html of the [JQuery ToDo app](https://github.com/addyosmani/todomvc/blob/gh-pages/architecture-examples/jquery/index.html) over to Hamlet,
adding remote scripts, and finagling with the [JQuery](https://github.com/addyosmani/todomvc/blob/gh-pages/architecture-examples/jquery/js/app.js) to get it to finally work perfectly.

* Fay Trouble
  * Next, I decided to jump right into [Fay](https://github.com/faylang/fay/wiki), a subset of Haskell that compiles to Javascript,
to refactor more logic into Haskell. I ran into a few complications, however, as Fay doesn't
support TemplateHaskell (and thus Hamlet), nor does it play nicely with Handlebar templates
(spent a few hours trying to encode and decode JSON, with single quotes here and double quotes
there all to no avail). Eventually, I was forced to hardcode the templates myself.

* Fay Proof-Of-Concept
  * I don't have enough time now to refactor our all of the todo persistance, editing and display
logic. However, as a proof-of-concept, I refactored out all of the logic of the "renderFooter"
function of the JQuery ToDoMVC example into fay.hs. And then I replaced all calls to renderFooter
in homepage.julis with calls to my new fay code, "main._(main.Test_Fay$main)". Not so pretty, but
it works.

Notes
=====

I played around with sessions a bit, but didn't get a chance to put the knowledge to work.
However, I left the code in place, just commented out, to display my progess.

Also, I wasn't able to figure out how to reference local javascript files (that aren't widget-ed julius)
so I just [hosted my compiled fay.js file on cloud.app](http://f.cl.ly/items/0Y2C203Q18170u460Q1v/fay.js) and referenced it remotely (as my main-man [Michael
Snoyman](http://www.yesodweb.com/blog/2013/01/adding-css-js) reccomends).
