EDITOR_CONFIG = YAML.load_file(Rails.root.join('config/portal_config.yml')).collect { |k, v|
  [k, v.collect {|value, label| { value: value, label: label } }]
}.to_h
