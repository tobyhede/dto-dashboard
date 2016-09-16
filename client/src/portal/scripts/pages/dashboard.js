import React, { Component, PropTypes } from 'react';
import { bindActionCreators } from 'redux';
import { Link } from 'react-router';
import { connect } from 'react-redux';
import UpdateDashboardForm from './../components/forms/update-dashboard-form';


const mapStateToProps = (store, ownProps) => ({
  dashboard: ownProps.dashboard,
  widgets: ownProps.widgets
});
const mapDispatchToProps = null;


class DashboardIndex extends Component {

  onSubmitSuccess() {
    console.log('do something with success');
  }

  render() {
    let { dashboard, widgets } = this.props;

    return (
      <div>
        <h2>Dashboard: {dashboard.name}</h2>

        <UpdateDashboardForm initialValues={dashboard} onSubmitSuccess={this.onSubmitSuccess.bind(this)} />

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

