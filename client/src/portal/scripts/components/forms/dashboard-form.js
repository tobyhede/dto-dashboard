import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form';


let UpdateDashboardForm = (props) => {

  const {
    handleSubmit, pristine, submitting
  } = props;

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label htmlFor="name">Name</label>
        <div>
          <Field name="name" component="input" type="text"/>
        </div>
      </div>
      <div>
        <label htmlFor="notes">Notes</label>
        <div>
          <Field name="notes" component="textarea" />
        </div>
      </div>
      <div>
        <label htmlFor="url">Url</label>
        <div>
          <Field name="url" component="input" type="url"/>
        </div>
      </div>

      <div>
        <button type="submit" disabled={pristine || submitting}>Submit</button>
      </div>
    </form>
  )
};

const validate = (values, props) => {
  return {};
};

// decorate with reduxForm()
UpdateDashboardForm = reduxForm({
  form: 'updateDashboard',
  validate
})(UpdateDashboardForm);

// read the initialValues prop
UpdateDashboardForm = connect(
  (state, ownProps) => ({
    initialValues: ownProps.dashboard
  }),
)(UpdateDashboardForm);

export default UpdateDashboardForm
