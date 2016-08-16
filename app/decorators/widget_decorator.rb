class WidgetDecorator < Draper::Decorator
  delegate_all

  def summary
    return '' if (!has_data? || dataset.string?)

    date = dataset.previous.ts.to_formatted_s(:month_and_year)

    if dataset.changed?
      "#{dataset.trend.capitalize} by #{format(dataset.change)} since #{date}"
    else
      "#{dataset.trend.capitalize} since #{date}"
    end
  end

  def format(change)
    case
      when dataset.percentage?
        helpers.number_to_percentage(change.abs, :precision => 2)
      when dataset.money?
        helpers.number_to_currency(change.abs)
      when dataset.integer?
        change.abs.to_i
      else
        change.abs
    end
  end

  def to_chart
    
  end
end
