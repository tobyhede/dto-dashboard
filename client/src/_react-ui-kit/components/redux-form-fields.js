import React from 'react';
import moment from 'moment';


export const Input = (props) => {
  const {
    input, name, type, label,
    fieldProps,
    optionProps: { isOptional },
    meta: { touched, error }
  } = props;

  if (type === 'checkbox') {
    throw new Error('Use "checkbox" input instead.');
  }
  return (
    <div className="form-group">
      <label htmlFor={name}
             className="control-label">{label}{isOptional && <sup> Optional</sup>}</label>
      <div>
        <input {...input} {...fieldProps}
          type={type}
          name={name}
          id={name}
          className={touched && error ? `form-control invalid` : `form-control`} />
        {touched && error && <span className="help-block">{error}</span>}
      </div>
    </div>
  )
};

export const Date = (props) => {

  const {
    input, name, label,
    fieldProps,
    optionProps: { isOptional, format },
    meta: { touched, error }
  } = props;

  let computedValue = moment(input.value).format(format);

  return (
    <div className="form-group">
      <label htmlFor={name}
             className="control-label">{label}{isOptional === true && <sup> Optional</sup>}</label>
      <div>
        <input type="hidden" {...input} />
        <input {...fieldProps}
            type="text"
            value={computedValue}
            name={name}
            id={name}
            className={touched && error ? `form-control invalid` : `form-control`} />
        {touched && error && <span className="help-block">{error}</span>}
      </div>
    </div>
  )
};

export const Checkbox = (props) => {
  let checked = false;
  if (props.input.value) {
    checked = props.input.value;
    delete props.input.value;
  }

  const {
    input, name, label,
    fieldProps,
    optionProps: { isOptional },
    meta: { touched, error }
  } = props;

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

export const Textarea = (props) => {

  const {
    input, name, label,
    fieldProps,
    optionProps: { isOptional },
    meta: { touched, error }
  } = props;

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

export const Select = (props) => {

  const {
    input, name, label,
    fieldProps,
    optionProps: { isOptional, options },
    meta: { touched, error }
  } = props;

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
          {options.map((o, idx) => (
            <option key={idx} value={o.value}>{o.label}</option>
          ))}
        </select>
        {touched && error && <span className="help-block">{error}</span>}
      </div>
    </div>
  )
};
