import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm, SubmissionError } from 'redux-form';
import { isURL } from 'validator';

import { updateDataset } from './../../actions/dataset';
import Input from './../fields/input';
import Select from './../fields/select';
import Textarea from './../fields/textarea';
import SubmitButton from './../submitButton';


/**
 * Update Dataset Form
 * @param props
 * @component
 */
let UpdateDatasetForm = ({
  isEditing, isSubmitting, onCancelSuccess, OPTIONS_DATASET_LABEL,
  ...rfProps
}) => {

  const { error, handleSubmit, pristine, submitting, valid } = rfProps;

  return (
    <form onSubmit={(e) => e.preventDefault()}>

      <Field component={Input}
             name="name" type="text" label="Name"
             fieldProps={{disabled:!isEditing}} />

      <Field component={Input}
             name="label" type="text" label="Label"
             fieldProps={{disabled:!isEditing}} />

      <Field component={Select}
             name="units" label="Units"
             fieldProps={{disabled:!isEditing}}
             optionProps={{options:OPTIONS_DATASET_LABEL}} />

      <Field component={Textarea}
             name="notes" label="Notes"
             fieldProps={{disabled:!isEditing}}
             optionProps={{isOptional:true}} />

      <div>
        <SubmitButton type="submit"
                      btnText={isSubmitting ? 'Saving...' : 'Save'}
                      className='btn primary'
                      disabled={isSubmitting || pristine || !valid}
                      onClick={handleSubmit(submit.bind(this))} />

        <button type="cancel"
                className='btn primary-link'
                disabled={!isEditing || submitting}
                onClick={cancel.bind({}, rfProps, onCancelSuccess)}>Cancel</button>
      </div>
      <div className="form__help-block">
        {error && <strong>{error}</strong>}
      </div>
    </form>
  )
};

UpdateDatasetForm.defaultProps = {
  isSubmitting: false
};

UpdateDatasetForm.propTypes = {
  formModel: PropTypes.object.isRequired,
  onSubmitSuccess: PropTypes.func.isRequired,
  onCancelSuccess: PropTypes.func.isRequired,
  isEditing: PropTypes.bool,
  isSubmitting: PropTypes.bool,
  exclusionDates: PropTypes.array,
  OPTIONS_DATASET_LABEL: PropTypes.array.isRequired
};

/**
 * @param values
 * @param dispatch
 * @returns {Promise} - this function *must* return Promise, until
 *    resolve is called, its' submitting prop will be true
 */
const submit = (values, dispatch) => {
  return new Promise((resolve, reject) => {
    dispatch(updateDataset(values)).then(
      (data) => { // promise success
        if (data) {
          return resolve();
        }
        // server error
        return reject({message: data.message});
      },
      (error) => { // promise failed
        return reject(error);
      },
    ).catch((error) => {
      throw new SubmissionError({_error: error.message || 'Submit failed!'});
    });
  });
};

const validate = (values, props) => {
  const errors = {};

  if (!values.name) {
    errors.name = 'Required';
  }

  if (!values.label) {
    errors.label = 'Required';
  }

  if (!values.units) {
    errors.units = 'Required';
  }

  return errors;
};

const cancel = (rfProps, cb = ()=>{}) => {
  rfProps.reset(rfProps.form);
  cb();
};


UpdateDatasetForm = reduxForm({
  form: 'updateDatasetForm',
  validate,
  destroyOnUnmount: true
})(UpdateDatasetForm);

UpdateDatasetForm = connect(
  (state, ownProps) => ({
    enableReinitialize: true
  }),
  (dispatch, ownProps) => ({
    initialValues: ownProps.formModel
  })
)(UpdateDatasetForm);

export default UpdateDatasetForm
