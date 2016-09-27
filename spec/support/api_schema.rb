shared_context 'api_schema' do

  let(:dashboards_schema) { {
    :type => 'array',
    :items => [dashboard_schema]
  } }

  let(:dashboard_schema)   { {
    :type => 'object',
    :required => ['name', 'description', 'target_users'],
    :properties => {
      :name => {
        :type => 'string'
      },
      :description => {
        :type => 'string'
      },
      :target_users => {
        :type => 'string'
      },
      :notes => {
        :type => %w{string null}
      },
      :url => {
        :type => %w{string null}
      },
      :published_at => {
        :type => %w{string null},
        :format => 'date-time'
      }
    }

  } }

  let(:widgets_schema) { {
    :type => 'array',
    :items => [widget_schema]
  } }

  let(:widget_schema)   { {
    :type => 'object',
    :required => ['name', 'description', 'units', 'last_updated_at'],
    :properties => {
      :id => {
        :type => 'integer',
        :format => 'int64'
      },
      :dashboard_id => {
        :type => 'integer',
        :format => 'int64'
      },
      :name => {
        :type => 'string'
      },
      :description => {
        :type => 'string'
      },
      :pos => {
        :type => 'integer',
        :format => 'int32'
      },
      :row => {
        :type => 'integer',
        :format => 'int32'
      },
      :size => {
        :type => 'string'
      },
      :unit => {
        :type => 'string'
      },
      :type => {
        :type => 'string'
      },
      :is_hero => {
        :type => 'boolean'
      },
      :last_updated_at => {
        :type => 'string',
        :format => 'date-time'
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

  let(:datasets_schema) { {
    :type => 'array',
    :items => [dataset_schema]
  } }
  
  let(:dataset_schema)   { {
    :type => 'object',
    :required => ['id', 'name', 'label', 'units', 'created_at', 'updated_at'],
    :properties => {
      :id => {
        :type => 'integer',
        :format => 'int64'
      },
      :name => {
        :type => 'string'
      },
      :label => {
        :type => 'string'
      },
      :units => {
        :type => 'string'
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

  let(:datapoints_schema) { {
    :type => 'array',
    :items => [datapoint_schema]
  } }

  let(:datapoint_schema)   { {
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

  let(:error_schema)   { {
    :type => 'object',
    :required => ['code', 'message'],
    :properties => {
      :code => {
        :type => 'string'
      },
      :message => {
        :type => 'string'
      }
    }
  } }

end
