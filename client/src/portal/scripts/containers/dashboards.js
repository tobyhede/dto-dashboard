import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';


const mapStateToProps = ({dashboards}) => ({
  dashboards
});
const mapDispatchToProps = dispatch => ({});

class Dashboards extends Component {
  render() {
    return (
      <div>
        {React.cloneElement(this.props.children, {
          dashboards: this.props.dashboards
        })}
      </div>
    )
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Dashboards);
