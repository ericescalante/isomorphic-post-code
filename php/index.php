<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Sample PHP page rendering Node/ReactJS</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  </head>

  <body style="background:#FAFAFA;padding:20px">
    <div class="container">
      <div class="jumbotron">
      <h1>Sample PHP page</h1>
      <p>The content below is rendered server-side with PHP/node/react via dnode.</p>
      <p>Subsequent pagination is done with react client-side via Ajax.</p>
      <p>This could be a Drupal, Wordpress, or any other kind of PHP app :)</p>
    </div>

    <div class="panel panel-default" style="padding:20px;">
<?php 
  require 'vendor/autoload.php';

  $path =  explode('/', $_SERVER['REQUEST_URI']);

  $options  = array('page' => array_pop($path));
  $loop = new React\EventLoop\StreamSelectLoop();
  $dnode = new DNode\DNode($loop);
  $dnode->connect(3001, function($remote, $connection) use($options) {
    $remote->renderIndex($options, function($result) use ($connection) {
        echo $result;
        $connection->end();
    });
  });
  $loop->run();

?>
      </div>
    </div>
  </body>
</html>
