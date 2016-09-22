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

export const InputDate = (props) => {

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
        <input type="hidden" {...input} name={name} />
        <input {...fieldProps}
            type="text"
            value={computedValue}
             id={name}
             className={touched && error ? `form-control invalid` : `form-control`} />
        {touched && error && <span className="help-block">{error}</span>}
      </div>
    </div>
  )
};


export const DayMonthYearDate = (props) => {

  /**
   * Compute to consume
   */
  const getParsed = (ts) => {
    let _ts = moment(ts);
    return {
      d: _ts.date(),
      m: _ts.month(),
      y: _ts.year()
    }
  };

  const getToday = () => {
    let _ts = moment(new Date());
    return {
      d: _ts.date(),
      m: _ts.month(),
      y: _ts.year()
    }
  };

  /**
   * Compute to emit
   */
  const serialize = (d, m, y) => {
    return moment(`${y}-${m}-${d}`).toString();
  };

  const emit = (value) => {
    props.input.onBlur(value);
  };

  const onUpdateField = () => {
  debugger
    let refDay = this.refs.day;
    let refMonth = this.refs.month;
    let refYear = this.refs.year;

    emit(serialize(refDay.value, refMonth.value, refYear.value));
  };

  const getDayOptions = () => {
    let res = [];
    for (var i=1; i <= 31; i++) {
      res.push({label:String(i), value:i});
    }
    return res;
  };

  const getMonthOptions = () => {
    let res = [];
    let months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    for (var i=0; i<months.length; i++) {
      res.push({label:months[i], value:i});
    }
    return res;
  };

  const getYearOptions = () => {
    let res = [];
    let years = [
      '2015',
      '2016',
      '2017',
      '2018'
    ];
    for (var i=0; i<years.length; i++) {
      res.push({label:years[i], value:i});
    }
    return res;
  };


  const {
    input, name, label,
    fieldProps,
    optionProps: { isOptional },
    meta: { touched, error }
  } = props;

  const defaultVals = getToday();
  const parsedVals = getParsed();

  return (
    <div className="form-group">
      <label htmlFor={name}
             className="control-label">{label}{isOptional === true && <sup> Optional</sup>}</label>

      <input type="hidden" {...input} />

      <div className="date-fields--ddmmyyy">
        <div className="date-fields__field">
          <label htmlFor={`${name}_day`}>Day</label>
          <select id={`${name}_day`}
                  {...fieldProps}
                  default={defaultVals.d}
                  value={parsedVals.d}
                  onChange={(e) => onUpdateField()}>
            {getDayOptions().map((option, idx) => {
              return <option key={idx} value={option.value}>{option.label}</option>
            })}
          </select>
        </div>
        <div className="date-fields__field">
          <label htmlFor={`${name}_month`}>Month</label>
          <select id={`${name}_month`}
                  {...fieldProps}
                  default={defaultVals.m}
                  value={parsedVals.m}
                  onChange={(e) => onUpdateField()}>
            {getMonthOptions().map((option, idx) => {
              return <option key={idx} value={option.value}>{option.label}</option>
            })}
          </select>
        </div>
        <div className="date-fields__field">
          <label htmlFor={`${name}_year`}>Year</label>
          <select id={`${name}_year`}
                  {...fieldProps}
                  default={defaultVals.y}
                  value={parsedVals.y}
                  onChange={(e) => onUpdateField()}>
            {getYearOptions().map((option, idx) => {
              return <option key={idx} value={option.value}>{option.label}</option>
            })}
          </select>
        </div>
      </div>
      {touched && error && <span className="help-block">{error}</span>}
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
