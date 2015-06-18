React = require 'react'
Router = require 'react-router'
routes = require './routes'

Router.run routes, Router.HistoryLocation, (Handler, state) ->
  if window.initialPage == parseInt state.params.page
    React.render <Handler data={window.reactData} params={state.params}/>, document.getElementById('app')
  else
    component = state.routes[1].handler
    component.fetchData state.params, (err, data) ->
      React.render <Handler data={data} params={state.params}/>, document.getElementById('app')
