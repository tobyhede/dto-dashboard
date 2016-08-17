module ApplicationHelper

  def body_class(class_name="poo")
    content_for :body_class, class_name
  end

end
