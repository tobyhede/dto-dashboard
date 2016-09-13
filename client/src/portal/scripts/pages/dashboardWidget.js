import React, { Component, PropTypes } from 'react';
import { Link } from 'react-router';
import { connect } from 'react-redux';
import { getWidgetById } from './../reducers/widgets';
import { getDatasetsByIds } from './../reducers/datasets';


const mapStateToProps = ({datasets}, ownProps) => {
  let widget = getWidgetById(ownProps.widgets, ownProps.params.widget_id);
  return {
    dashboard: ownProps.dashboard,
    widget,
    datasets: getDatasetsByIds(datasets, widget.datasets)
  }
};
const mapDispatchToProps = dispatch => ({});

class Widget extends Component {

  render() {
    let { widget, dashboard, datasets } = this.props;
    return (
      <div>
        <h2>dashboard: {dashboard.name}</h2>
        <h2>widget: {widget.name}</h2>

        <div>
          <h3>Datasets</h3>
          <table>
            <thead>
            <tr>
              <td>ID</td><td>Name</td>
            </tr>
            </thead>
            <tbody>
            {datasets.map((d, idx) => (
              <tr key={idx}>
                <td>{d.id}</td><td>{d.name}</td><td><Link to={`/datasets/${d.id}`}>Edit</Link></td>
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
)(Widget);

