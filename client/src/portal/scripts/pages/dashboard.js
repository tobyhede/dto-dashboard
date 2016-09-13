import React, { Component, PropTypes } from 'react';
import { bindActionCreators } from 'redux';
import { Link } from 'react-router';
import { connect } from 'react-redux';
import DashboardForm from './../components/forms/dashboard-form';
import { updateDashboard } from './../actions/dashboard';


const mapStateToProps = (store, ownProps) => ({
  dashboard: ownProps.dashboard,
  widgets: ownProps.widgets
});
const mapDispatchToProps = dispatch => ({
  // submit: bindActionCreators(saveDashboard, dispatch)
});

class DashboardIndex extends Component {

  handleSubmit(data, dispatch) {
    dispatch(updateDashboard(this.props.dashboard.id, data));
    return false;
  }

  render() {
    let { dashboard, widgets } = this.props;

    return (
      <div>
        <h2>{dashboard.name}</h2>

        <DashboardForm onSubmit={this.handleSubmit.bind(this)} dashboard={dashboard} widgets={widgets} />

        <div>
          <h3>Widgets</h3>
            <table>
            <thead>
            <tr>
              <td>ID</td><td>Name</td>
            </tr>
            </thead>
            <tbody>
            {widgets.map((w, idx) => (
              <tr key={idx}>
                <td>{w.id}</td><td>{w.name}</td><td><Link to={`/dashboards/${dashboard.id}/widgets/${w.id}`}>Edit</Link></td>
              </tr>
            ))}
            </tbody>
          </table>
        </div>
      </div>
    )
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(DashboardIndex);

