import React, { PropTypes } from 'react';


export const Select = ({input, name, label, meta, fieldProps, optionProps }) => {

  const { isOptional, options } = optionProps;
  const { touched, error } = meta;

  return (
    <div className="form-group">
      <label htmlFor={name}
             className="control-label">{label}{isOptional === true && <sup> Optional</sup>}</label>
      <div>
        <select {...input} {...fieldProps}
                name={name}
                onBlur={() => {input.onBlur(input.value)}}
                id={name}
                className={touched && error ? `invalid` : ``}>
          <option value="">Select...</option>
          {options.map((o, idx) => (
            <option key={idx} value={o.value} disabled={o.disabled}>{o.label}</option>
          ))}
        </select>
        {touched && error && <span className="help-block">{error}</span>}
      </div>
    </div>
  )
};

Select.defaultProps = {
  fieldProps: {},
  optionProps: {}
};

Select.propTypes = {
  input: PropTypes.object.isRequired,
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired
};

export default Select;
