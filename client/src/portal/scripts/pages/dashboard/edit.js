import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { getDashboardById } from './../../reducers/dashboards'
import { push } from 'react-router-redux';
import { bindActionCreators } from 'redux';


const mapStateToProps = ({dashboards, routing}, ownProps) => ({
  routing,
  dashboard: getDashboardById(dashboards, ownProps.params.id)
});

const mapDispatchToProps = dispatch => ({
  toDashboard: ((id) => dispatch(push(`/dashboard/${id}`)))
  // cancel: bindActionCreators(cancelForm, dispatch)
  // submit: bindActionCreators(saveForm, dispatch)
});

class DashboardEdit extends Component {

  onCancel() {
    this.props.toDashboard(this.props.dashboard.id);
    // this.props.cancelForm();
  }

  render() {
    let { dashboard } = this.props;
    return (
      <div>
        <h1>Editing: {dashboard.title}</h1>

        <button onClick={this.onCancel.bind(this)}>Cancel</button>
      </div>
    )
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(DashboardEdit);
