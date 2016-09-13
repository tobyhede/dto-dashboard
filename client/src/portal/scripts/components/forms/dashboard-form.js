import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form';
import { bindActionCreators } from 'redux';
import { updateDashboard } from './../../actions/dashboard';
import { SubmissionError } from 'redux-form'


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


const sleep = ms => new Promise(resolve => setTimeout(resolve, ms))
function submit(data, dispatch) {
  return sleep(1000) // simulate server latency
    .then(() => {
      // if (![ 'john', 'paul', 'george', 'ringo' ].includes(values.name)) {
        // throw new SubmissionError({ name: 'Name does not exist', _error: 'Submit failed!' })
      // } else {
      dispatch(updateDashboard(data)); // todo - this will be async not sync
      window.alert(`You submitted:\n\n${JSON.stringify(data, null, 2)}`);
      // }
    });
}

let UpdateDashboardForm = props => {

  const { error, handleSubmit, pristine, submitting, valid } = props;

  return (
    <form onSubmit={handleSubmit(submit)}>
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
