# isomorphic-post-code

### What's going on here?
This little repo provides the companion code for the [isomorphic React in a PHP application](http://ericescalante.github.io/2015/06/07/isomorphic/) post. It contains a small node.js app and a tiny PHP app. 

I wrote the code for this post using coffeescript, I love it's simplicity and terseness (specially since I've been working on Rails for almost a year). As soon as react 0.14 comes out I'll do a rewrite using ES2015 (via Babel).

### Setup instructions
To get started, clone this repo then cd into the `isomorphic-post-code` directory. You will find inside a `nodejs` folder and a `php` fodler.
#### Node.js
Follow these steps to set up the node/react app:
``` 
cd nodejs
npm install
gulp
```
This will start the node server up, create the javascript bundle for the browser and inform you that it's ready to serve connections on ports 3000 and 3001.
#### PHP
Now, open a new terminal tab and go to the  `isomorphic-post-code` directory as well. Then type the following to get the PHP side of things going.
```
cd php
curl -sS https://getcomposer.org/installer | php
php composer.phar install
php -S localhost:8000
```
This will start a PHP server serving the index.php file by default.

### Playing with the node app
Now, to try the node/react app, point your browser to `http://localhost:3000/developers/page/1`. You should see this:

![Alt text](/screenshots/screenshot1.png?raw=true "node.js app")

Things to try out:
* Check on the traffic tab that only the first page is served as full document, the rest should come via ajax.
* Disable javascript, pagination should still work, this time as full page loads.
* View the page source, you can find the first list of developers as JSON string.
* Go directly to a specific page by typing the url like `http://localhost:3000/developers/page/666`, the behaviour should be the same.
* Bookmark the pages with your favourite developer avatars :)
* If you're really into hardcore experiences, visit the page with [lynx](http://lynx.browser.org/)!

### Now fiddle with the PHP one!
Go to `http://localhost:8000/developers/page/1` and you should see now the output of `index.php`:

![Alt text](/screenshots/screenshot2.png?raw=true "PHP app")

Things to try out:
* All of the above

Feel free to create an issue if something does not work quite as it should :)
