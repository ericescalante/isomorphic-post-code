require 'coffee-react/register'
https = require 'https'
React = require 'react'
Router = require 'react-router'
routes = require './routes'
dnode = require 'dnode'
express = require 'express'
app = express()
gutil = require 'gulp-util'


# HTTP server
app.get '/developers/page/*', (req, res) ->
  router = Router.create location: req.url, routes: routes
  router.run (Handler, state) ->
      component = state.routes[1].handler
      component.fetchData state.params, (err, data) ->
        response = '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">'
        response += "<script>window.reactData = #{JSON.stringify(data)}</script>"
        response += '<div id="app" class="container">'
        response += React.renderToString(React.createElement(Handler, data: data, params: state.params))        
        response += '</div>'
        response += '<script src="/js/bundle.js"></script>'
        res.send response

#static files
app.use express.static __dirname+'/public'

server = app.listen 3000, ->
  gutil.log 'HTTP: Listening on port 3000'

# dnode server
dserver = dnode
  renderIndex: (remoteParams, remoteCallback) ->
    router = Router.create location: '/developers/page/'+remoteParams.page, routes: routes
    processRoute router, remoteParams, remoteCallback

 processRoute = (router, remoteParams, remoteCallback) ->
  router.run (Handler, state) ->
    component = state.routes[1].handler
    component.fetchData state.params, (err, data) ->
      options = css:false, tags:false, assetsHost:'http://localhost:3001'
      _.extend options, globalOptions, remoteParams
      result =[renderTemplate(Handler, state, data, options), head(data)]
      remoteCallback result

dserver.listen 4000
gutil.log 'dnode: Listening on port 4000'
