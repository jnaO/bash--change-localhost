INSTALLATION
============

Clone repo to a folder of your discretion.

Create a symlink to a folder on your path (run `echo $PATH` in terminal to find out what folders you have in your path).

* `ln -s path/to/change_localhost/c-lhost.sh chost`
* restart your terminal


USAGE
=====

Make sure your webserver is pointing towards `~/Sites/localhost`.

run `chost` in the folder you want to use as localhost, or pass in a path as an argument as follows:
`chost client/projname/siteroot/`

Now there will be a symlink to the desired web root folder.
And by changing that symlink, you change your localhost.
No restart of your apache/equivalent server is needed.
This script automates the symlinking part.


