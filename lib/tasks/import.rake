require 'json'

namespace :import do
  desc 'Imports Data'
  task data: :environment do

    orgs = %w(mygov dibp industry imports )

    orgs.each do |name|

      puts "Importing: #{name}"

      file = File.read("lib/data/#{name}-data.json")
      data = JSON.parse(file)

      file = File.read("lib/data/#{name}-definition.json")
      definition = JSON.parse(file)

      organisation = Organisation.find_or_create_by!(:name => data['agency'], :url => data['url'])

      dashboard = Dashboard.find_or_create_by!(:name => definition['name'], :notes => definition['notes'], :organisation => organisation)
      dashboard.published_at = Time.now
      dashboard.save!

      datasets = {}

      data['datasets'].each do |dataset|
        units = dataset["units"] || 'n'
        dataset_model = Dataset.create!(
          :name => dataset['name'],
          :notes => dataset['note'],
          :organisation => organisation,
          :units => units)

        datasets[dataset['id']] = dataset_model

        # puts dataset['id']

        if dataset['data']

          dataset['data'].each do |data|
            ts = DateTime.strptime(data['label'], '%Y-%m')
            dataset_model.datapoints.create!(:ts => ts, :value => data['value'])
          end
        end
      end

      definition['widgets'].each do |widget|
        res = definition['layout'].collect.with_index{ |a, row|
          [row, a.index(widget['id'])] if a.index(widget['id'])
        }.compact.flatten

        # puts widget['id']
        description = widget['definition'].present? ? widget['definition'] : widget['description']
        is_hero = widget['is_hero'].present? ? widget['is_hero'] : false

        options = {}
        options['displayRoundedData'] = widget['displayRoundedData'] if widget['displayRoundedData'].present?
        options['stacking'] = widget['stacking'] if widget['stacking'].present?

        widget_model = Widget.create!(
          :dashboard => dashboard,
          :name => widget['name'],
          :description => description,
          :type => widget['type'],
          :size => widget['size'],
          :units => widget['units'],
          :is_hero => is_hero,
          :options => options,
          :row => res.first,
          :pos => res.last
        )

        if widget['datasets']
          widget['datasets'].each do |id|
            widget_model.datasets <<  datasets[id]
          end
          widget_model.save!
        end
      end
    end

  end
end
