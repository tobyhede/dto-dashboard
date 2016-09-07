module DashboardHelper

  def humanised_value(value, prefix, suffix)
    value.nil? ? 'no data' : "#{prefix} #{value} #{suffix}"
  end

end
