import React, { Component } from 'react';


export default class Dashboards extends Component {
  render() {
    return (
      <div>
        {this.props.children}
      </div>
    )
  }
}
