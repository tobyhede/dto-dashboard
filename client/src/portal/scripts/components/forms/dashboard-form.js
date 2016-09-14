import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form';
import { bindActionCreators } from 'redux';
import { updateDashboard } from './../../actions/dashboard';
import { SubmissionError } from 'redux-form'
import * as types from './../../actions/_types';


const renderInputField = ({ input, label, type, name, meta: { touched, error } }) => {
  return (
  <div>
    <label htmlFor={name}>{label}</label>
    <div>
      <input {...input} placeholder={label} type={type} name={name} />
      {touched && error && <span style={{color:'red'}}>{error}</span>}
    </div>
  </div>
)};

const renderTextareaField = ({ input, label, name, meta: { touched, error } }) => {
  return (
  <div>
    <label htmlFor={name}>{label}</label>
    <div>
      <textarea {...input} placeholder={label} name={name} />
      {touched && error && <span style={{color:'red'}}>{error}</span>}
    </div>
  </div>
)};


let submit = (data, dispatch) => {
  return new Promise((resolve, reject) => {
    dispatch(updateDashboard(data)).then(
      (data) => {
        if (data.type === types.UPDATE_DASHBOARD_FAIL) {
          reject(data);
        }
        resolve();
      },
      (error) => {
        reject(error);
      }
    );
  }).catch((data) => {
    // todo - check error and fail accordingly
    throw new SubmissionError({ name: 'Name does not exist', _error: 'Submit failed!' });
  });
};

let UpdateDashboardForm = props => {

  const { error, handleSubmit, pristine, submitting, valid } = props;

  // todo - 2. all fields
  return (
    <form onSubmit={handleSubmit(submit.bind(this))}>
      <Field name="name" type="text" component={renderInputField} label="Name"/>
      <Field name="notes" component={renderTextareaField} label="Notes"/>
      <Field name="url" type="text" component={renderInputField} label="url"/>
      <div>
        <button type="submit" disabled={pristine || submitting || !valid}>Submit</button>
      </div>
      {error && <strong style={{color:'red'}}>{error}</strong>}
    </form>
  )
};

const validate = (values, props) => {   // todo - 3. validation by type
  const errors = {};
  const requiredFields = ['name', 'notes', 'url'];
  requiredFields.forEach(field => {
    if (!values[field]) {
      errors[field] = 'Required'
    }
  });
  return errors;
};

// decorate with reduxForm
UpdateDashboardForm = reduxForm({
  form: 'updateDashboard',
  validate
})(UpdateDashboardForm);

// read the initialValues prop
UpdateDashboardForm = connect(
  (state, ownProps) => ({
    initialValues: ownProps.dashboard
  })
)(UpdateDashboardForm);

export default UpdateDashboardForm
