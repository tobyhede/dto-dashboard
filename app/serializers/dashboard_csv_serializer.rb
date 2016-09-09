class DashboardCSVSerializer < ActiveModel::Serializer

  def initialize(dashboard)
    @dashboard = dashboard

  end

  def to_csv
    CSV.generate({}) do |csv|
      csv.add_row CVS_COL_NAME

      @dashboard.widgets.each do |widget|
        datasets = widget.datasets
        datasets.each do |dataset|
          dataset.datapoints.each { |d| csv << [dataset.name, dataset.units, d.ts.strftime("%d/%m/%Y %H:%M"), d.label(), d.value.to_s] }
        end
      end
    end

  end

  private
  CVS_COL_NAME = ['dataset_name', 'units', 'time_stamp', 'label', 'value']

end
