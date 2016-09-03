import { Schema, arrayOf } from 'normalizr';


const widgetSchema = new Schema('widgets', {
  idAttribute: 'id',
  defaults: {}
});

const datumSchema = new Schema('datums', {
  idAttribute: 'id',
  defaults: {}
});

widgetSchema.define({
  datasets: arrayOf(datumSchema)
});


const Schemas = {
  WIDGET: widgetSchema,
  DATUM: datumSchema
};

export default Schemas;
