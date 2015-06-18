React = require 'react'

MiniProfile = React.createClass
  displayName: 'MiniProfile'
  render: ->
    user = this.props.user
    <div className="pull-left">
      <img src={user.avatar_url} style={width:120, padding:10} className="img-circle pull-left"/>
      <div className="text-center">
        <a href={user.html_url} target="_blank"><span className="label label-info">{user.login}</span></a>
      </div>
    </div>

module.exports = MiniProfile