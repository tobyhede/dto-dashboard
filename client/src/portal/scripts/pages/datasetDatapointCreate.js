import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router';


const mapStateToProps = (store, ownProps) => ({
  dataset: ownProps.dataset
});
const mapDispatchToProps = dispatch => ({});

class DatasetDatapointCreatePage extends Component {
  render() {
    let { dataset } = this.props;
    return (
      <div>
        <h1>Create datapoint</h1>
      </div>
    )
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(DatasetDatapointCreatePage);
