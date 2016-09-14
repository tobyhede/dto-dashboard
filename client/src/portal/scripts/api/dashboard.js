import { USE_FIXTURES } from './../config';


/**
 * @param id
 * @param data
 * @returns {Promise}
 */

// todo - real !
export const update = (id, data) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve({data, status:'success'});  // success interface
      // reject();                           // failure interface
    }, 800);
  });
};

