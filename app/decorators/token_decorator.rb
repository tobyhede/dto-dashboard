class TokenDecorator < Draper::Decorator
  delegate_all

  def display_name
    "Token #{id}"
  end

end
