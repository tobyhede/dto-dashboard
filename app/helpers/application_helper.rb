module ApplicationHelper

  # Sets the body data-route value on a per-page basis
  # Params:
  # - class_names: String of class names to append to class names string
  def body_route
    "#{controller_name}_#{action_name}"
  end

  # Sets the body class on a per-page basis
  # Params:
  # - class_names: {Array} Array of additional class names to append to body class
  # names
  def body_class(names)
    class_names = [body_route] << names
    class_names.flatten.join(' ')
  end

  def display_high_contrast_mode?
    controller.controller_name == 'dashboards' && controller.action_name == 'show'
  end
end
