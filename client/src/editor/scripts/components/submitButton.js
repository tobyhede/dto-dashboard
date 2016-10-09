import React, { PropTypes } from 'react';


const Button = ({btnText, ...attrs}) => {
  return (
    <button {...attrs}>{btnText}</button>
  )
};

Button.propTypes = {
  btnText: PropTypes.string.isRequired
};

export default Button;
