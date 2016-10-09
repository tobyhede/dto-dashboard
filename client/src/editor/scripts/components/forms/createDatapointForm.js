import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm, SubmissionError } from 'redux-form';
import { push } from 'react-router-redux';
import { isFloat } from 'validator';  // todo - use lodash instead

import { createDatapoint } from './../../actions/datapoint';
import Input from './../fields/input';
import YyyyMmDate from './../fields/yyyyMmDate';
import SubmitButton from './../submitButton';


/**
 * Create Datapoint Form
 * @param props
 * @component
 */
let CreateDatapointForm = ({
  exclusionDates, isSubmitting, onCancelSuccess,
  ...rfProps
}) => {

  const { error, handleSubmit, pristine, valid } = rfProps;

  return (
    <form onSubmit={(e) => e.preventDefault()}>

      <Field component={YyyyMmDate}
             type="text" name="ts" label="Label"
             optionProps={{exclusionDates}} />

      <Field component={Input}
             type="number"  name="value" label="Value"
             optionProps={{infoText: `Leave blank to save as "No data"`}} />

      <div>
        <SubmitButton type="submit"
                btnText={isSubmitting ? 'Creating...' : 'Create'}
                className='btn primary'
                disabled={isSubmitting || pristine || !valid}
                onClick={handleSubmit(submit.bind(this))} />

        <button type="cancel"
                className='btn primary-link'
                disabled={isSubmitting}
                onClick={cancel.bind({}, rfProps, onCancelSuccess)}>Cancel</button>
      </div>
      <div className="form__help-block">
        {error && <strong>{error}</strong>}
      </div>
    </form>
  )
};

CreateDatapointForm.defaultProps = {
  isSubmitting: false
};

CreateDatapointForm.propTypes = {
  dataset: PropTypes.object.isRequired,
  onSubmitSuccess: PropTypes.func.isRequired,
  onCancelSuccess: PropTypes.func.isRequired,
  isSubmitting: PropTypes.bool,
  exclusionDates: PropTypes.array
};


/**
 * @param values
 * @param dispatch
 * @param props - todo
 * @returns {Promise} - this function *must* return Promise, until
 * resolve is called, its' submitting prop will be true
 */
const submit = (values, dispatch, props) => { // todo

  values.dataset_id = props.dataset.id;

  return new Promise((resolve, reject) => {
    dispatch(createDatapoint(values)).then(
      (data) => {
        // debugger
        if (data) { // todo - extract this
          let newDatasetState = {...props.dataset};
          newDatasetState.datapoints.push(data.id);
          // dispatch(updateDataset(newDatasetState)); // todo - handle this fail  // TDODO
          return resolve();
        }
        return reject({message: 'an error message from server'});
      },
      (error) => {
        return reject({message: `an error message: ${error}`});
      },
    ).catch((error) => {
      // todo - check error and fail accordingly
      console.error(error);
      throw new SubmissionError({name: 'Name does not exist', _error: 'Submit failed!'});
    });
  });
};


const validate = (values, props) => {   // todo - validate
  const errors = {};

  if (values.value && !isFloat(String(values.value))) {
    errors.value = 'Must be blank or a number.';
  }

  return errors;
};

const cancel = (rfProps, cb = ()=>{}) => {
  rfProps.reset();
  cb();
};


CreateDatapointForm = reduxForm({
  form: 'createDatapointForm',
  validate,
  destroyOnUnmount: true
})(CreateDatapointForm);


export default CreateDatapointForm;
