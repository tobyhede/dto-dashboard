import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { getDatasetById } from './../reducers/datasets';


const mapStateToProps = ({datasets}, ownProps) => ({
  dataset: getDatasetById(datasets, ownProps.params.dataset_id),
});
const mapDispatchToProps = dispatch => ({});

class Dataset extends Component {
  render() {
    return (
      <div>
        {React.cloneElement(this.props.children, {
          dataset: this.props.dataset
        })}
      </div>
    )
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Dataset);
