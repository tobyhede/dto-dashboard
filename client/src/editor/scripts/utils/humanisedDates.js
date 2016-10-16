import moment from 'moment';
import { ISO_LONG_DATE } from './../../../_common/scripts/_vendor/gov-au-ui-kit/constants/date-time';


export const humanisedLongDate = (timestamp) => {
  return moment(timestamp).format(ISO_LONG_DATE);
};
