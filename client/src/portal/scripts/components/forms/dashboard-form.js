import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form';
import { updateDashboard } from './../../actions/dashboard';
import { SubmissionError } from 'redux-form'
import * as types from './../../actions/_types';
import isValidUrl from './../../utils/isValidUrl';


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


const submit = (data, dispatch) => {
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

  return (
    <form onSubmit={handleSubmit(submit.bind(this))}>
      <Field name="name" type="text" component={renderInputField} label="Name"/>
      <Field name="notes" component={renderTextareaField} label="Notes"/>
      <Field name="url" type="text" component={renderInputField} label="Url"/>
      <Field name="display_hero" type="checkbox" component={renderInputField} label="Display hero"/>
      <Field name="display_kpis" type="checkbox" component={renderInputField} label="Display kpi"/>
      <div>
        <button type="submit" disabled={pristine || submitting || !valid}>Submit</button>
      </div>
      {error && <strong style={{color:'red'}}>{error}</strong>}
    </form>
  )
};

const validate = (values, props) => {
  const errors = {};
  const requiredFields = ['name', 'notes', 'url'];
  requiredFields.forEach(field => {
    if (!values[field]) {
      errors[field] = 'Required'
    }
  });

  if (!errors['url'] && isValidUrl(values.url) === false) {
    errors['url'] = 'Must be a valid URL'
  }

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
