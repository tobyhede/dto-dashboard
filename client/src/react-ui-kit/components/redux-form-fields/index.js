import React from 'react';


export const Input = (props) => {
  let { input, label, type, name, meta: { touched, error } } = props;
  return (
    <div className="field">
      <label htmlFor={name}>{label}</label>
      <div>
        <input {...input} placeholder={label} type={type} name={name} id={name} className={touched && error ? `invalid` : ``} />
        {touched && error && <span className="field___error">{error}</span>}
      </div>
    </div>
  )
};

export const Textarea = (props) => {
  let { input, label, name, meta: { touched, error } } = props;
  return (
    <div className="field">
      <label htmlFor={name}>{label}</label>
      <div>
        <textarea {...input} placeholder={label} name={name} id={name} className={touched && error ? `invalid` : ``} />
        {touched && error && <span className="field___error">{error}</span>}
      </div>
    </div>
  )
};

export const Select = (props) => {
  let { input, label, name, options, meta: { touched, error } } = props;
  return (
    <div className="field">
      <label htmlFor={name}>{label}</label>
      <div>
        <select {...input} name={name} onBlur={() => {input.onBlur(input.value)}} id={name} className={touched && error ? `invalid` : ``}>
          {options.map((o, idx) => (
            <option key={idx} value={o.value}>{o.label}</option>
          ))}
        </select>
        {touched && error && <span className="field___error">{error}</span>}
      </div>
    </div>
  )
};
