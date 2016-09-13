import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form';


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


let UpdateDashboardForm = props => {

  const {
    handleSubmit, pristine, submitting
  } = props;

  return (
    <form onSubmit={handleSubmit}>
      <Field name="name" type="text" component={renderInputField} label="Name"/>
      <Field name="notes" component={renderTextareaField} label="Notes"/>
      <Field name="url" type="text" component={renderInputField} label="url"/>

      <div>
        <button type="submit" disabled={pristine || submitting}>Submit</button>
      </div>
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
  return errors;
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
  })
)(UpdateDashboardForm);

export default UpdateDashboardForm
