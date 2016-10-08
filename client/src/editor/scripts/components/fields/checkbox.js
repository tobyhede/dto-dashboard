import React, { PropTypes } from 'react';


const Checkbox = ({input, name, label, fieldProps, optionProps, meta }) => {
  let checked = false;
  if (input.value) {
    checked = input.value;
    delete input.value;
  }

  const { isOptional } = optionProps;
  const { touched, error } = meta;

  return (
    <div className="form-group">
      <input {...input} {...fieldProps}
             checked={checked}
             type="checkbox"
             name={name}
             id={name}
             className={touched && error ? `invalid` : ``} />
      <label htmlFor={name}>{label}{isOptional === true && <sup> Optional</sup>}</label>
      <div>
        {touched && error && <span className="help-block">{error}</span>}
      </div>
    </div>
  )
};

Checkbox.defaultProps = {
  fieldProps: {},
  optionProps: {}
};

Checkbox.propTypes = {
  input: PropTypes.object.isRequired,
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired
};

export default Checkbox;
