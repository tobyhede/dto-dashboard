module ApplicationHelper

  # Sets the body class on a per-page basis
  def body_class(class_names)
    class_name_str = self.controller_name + '_' + self.action_name
    if !class_names.empty?
      class_name_str << ' ' + class_names
    end
    return class_name_str
  end

end
