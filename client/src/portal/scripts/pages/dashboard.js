import React, { Component, PropTypes } from 'react';
import { Link } from 'react-router';


class Dashboard extends Component {

  render() {
    return (
      <div>
        <Link to="/dashboards">Back to My Dashboards</Link>
        <div>
          {this.props.children}
        </div>
      </div>
    )
  }
}

export default Dashboard;
