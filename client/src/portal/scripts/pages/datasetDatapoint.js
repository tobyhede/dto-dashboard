import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router';
import { getDatapointById } from './../reducers/datapoints';
import UpdateDatapointForm from './../components/forms/update-datapoint-form';


const mapStateToProps = ({datapoints}, ownProps) => {
  return {
    dataset: ownProps.dataset,
    datapoint: getDatapointById(datapoints, ownProps.params.datapoint_id)
  }
};
const mapDispatchToProps = dispatch => ({});

class DatasetDatapointPage extends Component {
  render() {
    let { dataset, datapoint } = this.props;
    return (
      <div>
        <h1>Dataset Datapoint</h1>

        <UpdateDatapointForm initialValues={datapoint} />

      </div>
    )
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(DatasetDatapointPage);
