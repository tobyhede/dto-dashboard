class DashboardDecorator < Draper::Decorator
  delegate_all

  def recorded_at
    # return _.last(_.map(this.data.datasets, (d) => d.recorded_at).sort());
    # object.datasets.
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
