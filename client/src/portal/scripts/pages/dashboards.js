import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router';


const mapStateToProps = ({dashboards}) => ({
  dashboards
});

const mapDispatchToProps = dispatch => ({});

class Dashboards extends Component {

  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    let { dashboards } = this.props;
    return (
      <div>
        <h1>Dashboards</h1>
        <ul>
          {dashboards.map((d, idx) => {
            return <li key={idx}><Link to={`/dashboard/${d.id}`}>{d.id} - {d.title}</Link></li>
          })}
        </ul>
      </div>
    )
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Dashboards);
