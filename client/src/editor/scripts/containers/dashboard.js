import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { getDashboardById } from './../reducers/dashboards';
import { getWidgetsByDashboardId } from './../reducers/widgets';


const mapStateToProps = ({dashboards, widgets}, ownProps) => {
  let dashboard = getDashboardById(dashboards, ownProps.params.dashboard_id);
  return {
    dashboard: dashboard,
    widgets: getWidgetsByDashboardId(widgets, dashboard.id)
  }
};
const mapDispatchToProps = dispatch => ({});

class Dashboard extends Component {
  render() {
    return (
      <div>
        {React.cloneElement(this.props.children, {
          dashboard: this.props.dashboard,
          widgets: this.props.widgets
        })}
      </div>
    )
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Dashboard);


