React = require 'react'
request = require 'request'
MiniProfile = require './miniprofile.cjsx'
Pagination = require './pagination.cjsx'

DeveloperList = React.createClass
  displayName: 'DeveloperList'
  statics:
    fetchData: (params, callback) ->
      'Fetching from Github'
      options =
        url: "https://api.github.com/users?since=#{params.page*30}"
        headers:
          'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20100101 Firefox/21.0'
        withCredentials:false
      request options, (error, response, body) ->
        return callback null, false if response.statusCode != 200
        callback null, JSON.parse body
  render: ->
    profiles = []
    this.props.data.forEach (user, index) ->
      profiles.push <MiniProfile key={index} user={user}/>

    <div>
      <div className="row">
        {profiles}
      </div>
      <Pagination currentPage={parseInt this.props.params.page}/>
    </div>

module.exports = DeveloperList