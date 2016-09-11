import React, { Component, PropTypes } from 'react';
import { Link } from 'react-router';
import { connect } from 'react-redux';
import { getDashboardById } from './../../reducers/dashboards'


const mapStateToProps = ({dashboards}, ownProps) => ({
  dashboard: getDashboardById(dashboards, ownProps.params.id)
});
const mapDispatchToProps = null;

class DashboardIndex extends Component {

  render() {
    let { dashboard } = this.props;

    return (
      <div>
        <h1>{dashboard.title}</h1>

        <Link to={`/dashboard/${dashboard.id}/edit`}>Edit</Link>
      </div>
    )
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(DashboardIndex);

