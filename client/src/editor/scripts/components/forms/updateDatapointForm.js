import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm, SubmissionError } from 'redux-form';
import { isFloat } from 'validator';

import { updateDatapoint } from './../../actions/datapoint';
import Input from './../fields/input';
import SubmitButton from './../submitButton';
import YyyyMmDate from './../fields/yyyyMmDate';


/**
 * Update Datapoint Form
 * @param props
 * @component
 */
let UpdateDatapointForm = ({
  isSubmitting, onCancelSuccess,
  ...rfProps
}) => {

  const { error, handleSubmit, submitting, valid } = rfProps;

  return (
    <form onSubmit={(e) => e.preventDefault()}>

      <Field component={YyyyMmDate}
             type="text" name="ts" label="Label"
             fieldProps={{readOnly:true, disabled:true}} />

      <Field component={Input}
             type="number" name="value" label="Value"
             optionProps={{infoText: `Leave blank to save as "No data"`}} />

      <div>
        <SubmitButton type="submit"
                btnText={isSubmitting ? 'Saving...' : 'Save'}
                className='btn primary'
                disabled={isSubmitting || !valid}
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

UpdateDatapointForm.defaultProps = {
  isSubmitting: false
};

UpdateDatapointForm.propTypes = {
  formModel: PropTypes.object.isRequired,
  dataset: PropTypes.object.isRequired,
  onSubmitSuccess: PropTypes.func.isRequired,
  onCancelSuccess: PropTypes.func.isRequired,
  isSubmitting: PropTypes.bool
};


/**
 * @param values
 * @param dispatch
 * @returns {Promise} - this function *must* return Promise, until
 *    resolve is called, its' submitting prop will be true
 */
const submit = (values, dispatch, props) => {

  values.dataset_id = props.dataset.id;

  return new Promise((resolve, reject) => {
    dispatch(updateDatapoint(values)).then(
      (data) => {
        if (data) {
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

const validate = (values, props) => {
  const errors = {};

  if (values.value && !isFloat(String(values.value))) {
    errors.value = 'Must be blank or a number.';
  }
  return errors;
};


const cancel = (rfProps, cb = ()=>{}) => {
  rfProps.reset(rfProps.form);
  cb();
};


UpdateDatapointForm = reduxForm({
  form: 'updateDatapointForm',
  validate,
  destroyOnUnmount: true
})(UpdateDatapointForm);

UpdateDatapointForm = connect(
  (state, ownProps) => ({
    enableReinitialize: true
  }),
  (dispatch, ownProps) => ({
    initialValues: ownProps.formModel
  })
)(UpdateDatapointForm);

export default UpdateDatapointForm
