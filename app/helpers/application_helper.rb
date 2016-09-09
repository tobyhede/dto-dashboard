module ApplicationHelper

  # Sets the body class on a per-page basis
  # Params:
  # - class_names: {Array} Array of additional class names to append to body class
  # names
  def body_class(names)
    class_names = ["#{controller_name}_#{action_name}"] << names
    class_names.flatten.join(' ')
  end

  def display_high_contrast_mode?
    controller.controller_name == 'dashboards' && controller.action_name == 'show'
  end
end
