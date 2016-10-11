import React, { PropTypes } from 'react';


const Textarea = ({input, name, label, meta, fieldProps, optionProps}) => {

  const { isOptional } = optionProps;
  const { touched, error } = meta;

  return (
    <div className="form-group">
      <label htmlFor={name}
             className="control-label">{label}{isOptional === true && <sup> Optional</sup>}</label>
      <div>
        <textarea {...input} {...fieldProps}
                  name={name}
                  id={name}
                  className={touched && error ? `invalid` : ``} />
        {touched && error && <span className="help-block">{error}</span>}
      </div>
    </div>
  )
};

Textarea.defaultProps = {
  fieldProps: {
    autoComplete: 'off',
    rows: 5
  },
  optionProps: {}
};

Textarea.propTypes = {
  input: PropTypes.object.isRequired,
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired
};

export default Textarea;
