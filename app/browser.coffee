React = require 'react'
Router = require 'react-router'
routes = require './routes'

Router.run routes, Router.HistoryLocation, (Handler, state) ->
  component = state.routes[1].handler
  component.fetchData state.params, (err, data) ->
    React.render <Handler data={data} params={state.params}/>, document.getElementById('app')
