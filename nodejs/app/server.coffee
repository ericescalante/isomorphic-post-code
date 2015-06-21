require 'coffee-react/register'
React = require 'react'
Router = require 'react-router'
routes = require './routes'
dnode = require 'dnode'
express = require 'express'
app = express()
gutil = require 'gulp-util'

regularPort = 3000
dnodePort = 3001

# HTTP server
app.get '/developers/page/*', (req, res) ->
  router = Router.create location: req.url, routes: routes
  router.run (Handler, state) ->
      gutil.log "Serving to browser via #{regularPort}"
      component = state.routes[1].handler
      component.fetchData state.params, (err, data) ->
        reacOutput = React.renderToString(React.createElement(Handler, data: data, params: state.params))        
        res.send(getHtml(reacOutput, data, state))

#static files
app.use express.static __dirname+'/public'

server = app.listen regularPort, ->
  gutil.log "HTTP: Listening on port #{regularPort}"

getHtml = (reacOutput, data, state) ->
  response = '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">'
  response += "<script>window.reactData = #{JSON.stringify(data)}</script>"
  response += "<script>window.initialPage = #{state.params.page}</script>"
  response += '<div id="app" class="container">'
  response += reacOutput
  response += '</div>'
  response +=  "<script src='http://localhost:#{regularPort}/js/bundle.js'></script>"

# dnode server
dserver = dnode
  renderIndex: (remoteParams, remoteCallback) ->
    router = Router.create location: '/developers/page/'+remoteParams.page, routes: routes
    router.run (Handler, state) ->
      gutil.log "Serving to PHP via #{dnodePort}"
      component = state.routes[1].handler
      component.fetchData state.params, (err, data) ->
        reacOutput = React.renderToString(React.createElement(Handler, data: data, params: state.params))        
        remoteCallback(getHtml(reacOutput, data, state))

dserver.listen dnodePort
gutil.log "dnode: Listening on port #{dnodePort}"
