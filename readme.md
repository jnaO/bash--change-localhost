INSTALLATION
============

Clone repo to a folder of your discretion.

Create a symlink to a folder on your path (run `echo $PATH` in terminal to find out what folders you have in your path).

* `ln -s path/to/change_localhost/c-lhost.sh chost`
* restart your terminal
* run `chost` in the folder you want to use as localhost, or pass in relative path (directly below your current position only) as an argument as follows:

    `chost client/projname/siteroot/`

Make sure your webserver is pointing towards ~/Sites/localhost.


Known issues
============

As of right now this scrip can not handle relative paths that traverse upwards, I.E. `../somefolder/desired_webroot/` will not work.
Neither can this script handle absolute paths, I.E. `/Users/username/web_root/` or `~/web_root/`