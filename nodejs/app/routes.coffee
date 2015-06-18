React = require('react')
Route = require('react-router').Route

module.exports = [
  <Route>
    <Route name='index' path="/developers/page/:page" handler={require('./developer_list.cjsx')} />
  </Route>
]
