import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux'
import { Field, reduxForm, SubmissionError } from 'redux-form';
import { isURL } from 'validator';

import { updateDashboard } from './../../actions/dashboard';
import Input from './../fields/input';
import InputDate from './../fields/inputDate';
import Textarea from './../fields/textarea';
import SubmitButton from './../submitButton';


/**
 * Update Dashboard Form
 * @param props
 * @component
 */
let UpdateDashboardForm = ({
  isEditing, isSubmitting, onCancelSuccess,
  ...rfProps
}) => {

  const { error, handleSubmit, pristine, valid } = rfProps;

  return (
    <form onSubmit={(e) => e.preventDefault()}>

      <Field component={Input}
             name='name' type='text' label='Name'
             fieldProps={{disabled:!isEditing}} />

      <Field component={Textarea}
             name='description' label='Description'
             fieldProps={{disabled:!isEditing}} />

      <Field component={Textarea}
             name='target_users' label='Users Text'
             fieldProps={{disabled:!isEditing}} />

      <Field component={Input}
             name='url' type='url' label='Url'
             fieldProps={{disabled:!isEditing}}
             optionProps={{isOptional:true}} />

      <Field component={Textarea}
             name='notes' label='Notes'
             fieldProps={{disabled:!isEditing}}
             optionProps={{isOptional:true}} />

      <Field component={InputDate}
             name='published_at' label='Published at'
             fieldProps={{readOnly:true}} />

      <div>
        <SubmitButton type="submit"
                      btnText={isSubmitting ? 'Saving...' : 'Save'}
                      className='btn primary'
                      disabled={isSubmitting || pristine || !valid}
                      onClick={handleSubmit(submit.bind(this))} />
        <button type="cancel"
                className='btn primary-link'
                disabled={!isEditing || isSubmitting}
                onClick={cancel.bind({}, rfProps, onCancelSuccess)}>Cancel</button>
      </div>
      <div className="form__help-block">
        {error && <strong>{error}</strong>}
      </div>
    </form>
  )
};

UpdateDashboardForm.defaultProps = {
  isEditing: true,
  isSubmitting: false
};

UpdateDashboardForm.propTypes = {
  formModel: PropTypes.object.isRequired,
  onSubmitSuccess: PropTypes.func.isRequired,
  onCancelSuccess: PropTypes.func.isRequired,
  isSubmitting: PropTypes.bool,
  isEditing: PropTypes.bool
};


/**
 * @param values
 * @param dispatch
 * @returns {Promise} - this function *must* return Promise, until
 *    resolve is called, its' submitting prop will be true
 */
const submit = (values, dispatch) => {
  return new Promise((resolve, reject) => {
    dispatch(updateDashboard(values)).then(
      (data) => {
        if (data) {
          return resolve(); // todo
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

  if (!values.name) {
    errors.name = 'Required';
  }

  if (!values.description) {
    errors.description = 'Required';
  } else if (values.description.length > 240) {
    errors.description = 'Must be less than 240 characters';
  }

  if (!values.users) {
    errors.users = 'Required';
  } else if (values.users.length > 240) {
    errors.users = 'Must be less than 240 characters';
  }

  if (values.url.length && isURL(values.url) === false) {
    errors.url = 'Must be a valid URL';
  }

  return errors;
};

const cancel = (rfProps, cb = ()=>{}) => {
  rfProps.reset(rfProps.form);
  cb();
};


UpdateDashboardForm = reduxForm({
  form: 'updateDashboard',
  validate,
  destroyOnUnmount: true
})(UpdateDashboardForm);

UpdateDashboardForm = connect(
  (state, ownProps) => ({
    enableReinitialize: true
  }),
  (dispatch, ownProps) => ({
    initialValues: ownProps.formModel
  })
)(UpdateDashboardForm);

export default UpdateDashboardForm
