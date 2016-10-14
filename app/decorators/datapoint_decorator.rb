class DatapointDecorator < Draper::Decorator
  delegate_all

  def value(prefix, suffix)
    object.value.nil? ? 'no data' : "#{prefix} #{object.value} #{suffix}"
  end

end
