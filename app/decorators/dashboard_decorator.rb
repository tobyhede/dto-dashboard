class DashboardDecorator < Draper::Decorator
  delegate_all

  def show_hero?
    display_hero && display_kpis && widgets.hero.present?
  end

  def show_kpis?
    display_kpis && widgets.kpis.any?
  end

  def show_notes?
    notes.present?
  end

  def show_url?
    url.present?
  end

  def name_slug
    name.downcase.parameterize()
  end

  def notes_to_html
    markdown.render(notes).html_safe
  end

  def name
    object.name.gsub(/dashboard/i, '').strip
  end

  def dashboardized_name
    name.downcase.index('dashboard') ? name : "#{name} Dashboard"
  end

  def last_updated_at
    object.last_updated_at.to_formatted_s(:month_year)
  end

  def to_csv
    CSV.generate( {} ) do |csv|
      csv.add_row CVS_COL_NAME

      # export KPI data
      self.first_row.each do |kpi|
        widget = kpi.decorate

        kpi_values ||= []
        kpi_values.push(widget.id || " ")
        kpi_values.push(widget.name || " ")
        kpi_values.push(widget.type || " ")
        kpi_values.push(widget.size || " ")
        kpi_values.push(widget.units || " ")
        kpi_values.push(widget.description || " ")
        kpi_values.push(widget.options || " ")

        widget.datasets.each do |dataset|
          if dataset.datapoints != nil
            dataset.datapoints.each do |datapoint|
              dp_values ||= []
              dp_values.push(datapoint.label() || " ")
              dp_values.push(datapoint.value || " ")
              csv.add_row kpi_values + dp_values
            end
          else
            dp_values ||=[" ", " "]
            csv.add_row kpi_values + dp_values
          end
        end

      end

      # export other wiget data
      self.remaining_rows.each do |other_widget|
        widget = other_widget.decorate

        wi_values ||= []
        wi_values.push(widget.id || " ")
        wi_values.push(widget.name || " ")
        wi_values.push(widget.type || " ")
        wi_values.push(widget.size || " ")
        wi_values.push(widget.units || " ")
        wi_values.push(widget.description || " ")
        wi_values.push(widget.options || " ")

        widget.datasets.each do |dataset|
          if dataset.datapoints != nil
            dataset.datapoints.each do |datapoint|
              dp_values ||= []
              dp_values.push(datapoint.label() || " ")
              dp_values.push(datapoint.value || " ")
              csv.add_row wi_values + dp_values
            end
          else
            dp_values ||=[" ", " "]
            csv.add_row wi_values + dp_values
          end
        end

      end

    end

    # uncomment following for debugging only
    # puts cnt.to_s
    # return cnt
  end

  private
  CVS_COL_NAME = ['id', 'last_updated_at', 'name','type','size','units','description', 'options', 'data_label', 'data_value']

  def markdown
    render_options = {
      # will remove from the output HTML tags inputted by user
      filter_html: true,
      # will insert <br /> tags in paragraphs where are newlines
      # (ignored by default)
      hard_wrap: true,
      # hash for extra link options, for example 'nofollow'
      link_attributes: {rel: 'nofollow'}
      # more
      # will remove <img> tags from output
      # no_images: true
      # will remove <a> tags from output
      # no_links: true
      # will remove <style> tags from output
      # no_styles: true
      # generate links for only safe protocols
      # safe_links_only: true
      # and more ... (prettify, with_toc_data, xhtml)
    }
    renderer = Redcarpet::Render::HTML.new(render_options)

    extensions = {
      #will parse links without need of enclosing them
      autolink: true,
      # blocks delimited with 3 ` or ~ will be considered as code block.
      # No need to indent.  You can provide language name too.
      # ```ruby
      # block of code
      # ```
      fenced_code_blocks: true,
      # will ignore standard require for empty lines surrounding HTML blocks
      lax_spacing: true,
      # will not generate emphasis inside of words, for example no_emph_no
      no_intra_emphasis: true,
      # will parse strikethrough from ~~, for example: ~~bad~~
      strikethrough: true,
      # will parse superscript after ^, you can wrap superscript in ()
      superscript: true
      # will require a space after # in defining headers
      # space_after_headers: true
    }
    @markdown ||= Redcarpet::Markdown.new(renderer, extensions)
  end

end
