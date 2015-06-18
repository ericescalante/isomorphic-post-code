React = require 'react'
cx = require 'classnames'
Link = require('react-router').Link

Pagination = React.createClass
  displayName: 'Pagination'
  prevPage: (e) ->
    e.preventDefault()
    this.props.pageChanged this.props.currentPage - 1
  nextPage: (e) ->
    e.preventDefault()
    this.props.pageChanged this.props.currentPage + 1  
  render: ->
    prevClasses = cx
      'glyphicon': true
      'glyphicon-chevron-left': true
      'btn btn-primary': true
      'hidden': this.props.currentPage == 1
    <div className="row clearfix text-center" style={marginTop: 20}>
      <Link to="index" params={{page: this.props.currentPage - 1}} style={margin: 5}>
        <button className={prevClasses}>
        </button>
      </Link>
      <Link to="index" params={{page: this.props.currentPage + 1}} style={margin: 5}>
        <button className="glyphicon glyphicon-chevron-right btn btn-primary">
        </button>
      </Link>
    </div>

module.exports = Pagination