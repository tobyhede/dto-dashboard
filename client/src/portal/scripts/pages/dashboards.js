import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router';


const mapStateToProps = (store, ownProps) => ({
  dashboards: ownProps.dashboards
});
const mapDispatchToProps = dispatch => ({});

class DashboardsIndex extends Component {

  render() {
    let { dashboards } = this.props;

    let sortedDashboards = dashboards.sort((a,b) => {
      return new Date(b.ts).getTime() - new Date(a.ts).getTime();
    });

    return (
      <div>

        <div className="row">
          <div className="col-xs-12">
            <h1>Dashboards</h1>
          </div>
        </div>

        <div className="row">
          <div className="col-xs-12">
            <table className="content-table">
              <thead>
              <tr>
                <td>ID</td><td>Name</td>
              </tr>
              </thead>
              <tbody>
              {sortedDashboards.map((d, idx) => (
                <tr key={idx}>
                  <td>{d.id}</td><td>{d.name}</td><td><Link to={`/dashboards/${d.id}`} className="a--ui-kit">Edit</Link></td>
                </tr>
              ))}
              </tbody>
            </table>
          </div>
        </div>

      </div>
    )
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(DashboardsIndex);
