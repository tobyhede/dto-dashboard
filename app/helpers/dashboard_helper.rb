module DashboardHelper

  def size_to_style(size)
    return case size
             when 'extra-small' then
               'aus-width-one-fourth'
             when 'small' then
               'aus-width-one-third'
             when 'medium' then
               'aus-width-one-half'
             when 'large' then
               'aus-width-two-thirds'
             when 'full' then
               'aus-width-one-whole'
             else
               'aus-width-one-half'
           end
  end

  def humanised_value(value, prefix, suffix)
    value.nil? ? 'no data' : "#{prefix} #{value} #{suffix}"
  end

  def title_end_with_dashboard(name)
    if !name.downcase.index('dashboard') then
      name += ' Dashboard'
    end
    return name
  end
end
