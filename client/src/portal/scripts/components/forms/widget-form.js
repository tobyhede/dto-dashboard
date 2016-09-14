import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form';
import { SubmissionError } from 'redux-form'

import { updateWidget } from './../../actions/widget';
import * as types from './../../actions/_types';
import { isURL } from 'validator';



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

const renderSelectField = ({ input, label, name, options, meta: { touched, error } }) => {
  return (
    <div>
      <label htmlFor={name}>{label}</label>
      <div>
        <select {...input} name={name} onBlur={() => {input.onBlur(input.value)}}>
          {options.map((o, idx) => (
            <option key={idx} value={o.value}>{o.label}</option>
          ))}
        </select>
        {touched && error && <span style={{color:'red'}}>{error}</span>}
      </div>
    </div>
  )
};


/**
 * @param values
 * @param dispatch
 * @returns {Promise} - !important - this function *must* return Promise, until
 * resolve is called, its' submitting prop will be true
 */
const submit = (values, dispatch) => {
  // dispatch(startLoading());

  return new Promise((resolve, reject) => {
    dispatch(updateWidget(values)).then(
      (data) => {
        if (data.type === types.UPDATE_WIDGET_FAIL) {  // todo // if (data.status === 202) {}
          reject(data);
        }
        // dispatch(stopLoading());
        resolve();
      },
      (error) => {
        reject(error);
      }
    );
  }).catch((data) => {
    // dispatch(stopLoading());

    // todo - check error and fail accordingly
    throw new SubmissionError({ name: 'Name does not exist', _error: 'Submit failed!' });
  });
};


let UpdateWidgetForm = props => {

  const { error, handleSubmit, pristine, submitting, valid } = props;

  return (
    <form onSubmit={handleSubmit(submit.bind(this))}>

      {/*id: 1,*/}
      {/*row: 0,*/}
      {/*pos: 0,*/}
      <Field name="name" type="text" component={renderInputField} label="Name"/>

      <Field name="type" options={[
        { value: 'full', label: 'Full' },
        { value: 'kpi-sparkline', label: 'Kpi Sparkline' },
        { value: 'bar', label: 'Bar' },
        { value: 'fact', label: 'Fact' },
        { value: 'pie', label: 'Pie' }
      ]} component={renderSelectField} label="Type"/>

      <Field name="size" options={[
        { value: 'extra-small', label: 'Extra Small' },
        { value: 'small', label: 'Small' },
        { value: 'medium', label: 'Medium' },
        { value: 'large', label: 'Large' },
        { value: 'extra-large', label: 'Extra Large' }
      ]} component={renderSelectField} label="Size"/>

      <Field name="units" options={[
        { value: '%', label: 'Percentage' },
        { value: '$', label: 'Currency' },
        { value: 'n', label: 'Number' },
        { value: 'f', label: 'Float' },
        { value: 's', label: 'Seconds' }
      ]} component={renderSelectField} label="Units"/>
      <Field name="description" component={renderTextareaField} label="Description"/>
      {/*options: {},*/}
      <Field name="is_hero" type="checkbox" component={renderInputField} label="Is hero?"/>
      {/*last_updated_at: '2016-09-06 05:28:50.365576',*/}
      {/*created_at: '2016-09-06 05:28:50.356717',*/}
      {/*updated_at: '2016-09-06 05:28:50.366554',*/}

      <div>
        <button type="submit" disabled={pristine || submitting || !valid}>Submit</button>
      </div>
      {error && <strong style={{color:'red'}}>{error}</strong>}
    </form>
  )
};

const validate = (values, props) => {
  const errors = {};

  if (!values.name) {
    errors.name = 'Required';
  }

  // if (!values.notes) {
  //   errors.notes = 'Required';
  // }
  //
  // if (!values.url) {
  //   errors.url = 'Required';
  // } else if (isURL(values.url) === false) {
  //   errors.url = 'Must be a valid URL';
  // }

  return errors;
};

// decorate
UpdateWidgetForm = reduxForm({
  form: 'updateWidget',
  validate
})(UpdateWidgetForm);

// UpdateWidgetForm = connect(
//   (state, ownProps) => ({}),
//   (dispatch) => ({})
// (UpdateWidgetForm);

export default UpdateWidgetForm
