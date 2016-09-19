class TokenDecorator < Draper::Decorator
  delegate_all

  def token
    object.token[0..10]
  end

  def display_name
    "Token #{id}"
  end

end
