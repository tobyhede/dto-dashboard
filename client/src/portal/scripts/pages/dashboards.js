import React, { Component, PropTypes } from 'react';


export default class Dashboards extends Component {
  render() {
    return (
      <div>
        <h1>Dashboards</h1>
        {this.props.children}
      </div>
    )
  }
}
