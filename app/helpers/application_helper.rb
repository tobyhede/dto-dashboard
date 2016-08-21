module ApplicationHelper

  # Sets the body class on a per-page basis
  # Params:
  # - class_names: Array of additional class names to append to body class
  # names
  def body_class(names)
    class_names = [self.controller_name + '_' + self.action_name]
    if !names.empty?
      class_names.push(names);
    end
    return class_names.join(' ');
  end

end
