shared_context 'api_schema' do

  let(:datapoints_schema) { {
    :type => 'array',
    :items => [datapoint_schema]
  } }

  let(:datapoint_entity_schema)   { {
    :type => 'object',
    :required => ['id', 'ts', 'value', 'created_at', 'updated_at'],
    :properties => {
      :ts => {
        :type => 'string',
        :format => 'date-time'
      },
      :value => {
        :type => 'string',
        :format => 'double'
      },
      :created_at => {
        :type => 'string',
        :format => 'date-time'
      },
      :updated_at => {
        :type => 'string',
        :format => 'date-time'
      }
    }

  } }

  let(:datapoint_schema)   { {
    :type => 'object',
    :required => ['ts', 'value'],
    :properties => {
      :ts => {
        :type => 'string',
        :format => 'date-time'
      },
      :value => {
        :type => 'string',
        :format => 'double'
      }
    }

  } }


end
