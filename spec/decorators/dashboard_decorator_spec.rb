require 'rails_helper'

RSpec.describe DashboardDecorator, type: :decorator do

  context 'dashboard' do
    let(:dashboard) { FactoryGirl.create(:dashboard) }
    subject {dashboard.decorate}
    it { is_expected.to_not be_show_hero }
    it { is_expected.to_not be_show_kpis }
  end

  context 'dashboard with widgets' do
    let(:dashboard) { FactoryGirl.create(:dashboard_with_widgets) }
    subject {dashboard.decorate}

    it { is_expected.to be_show_hero }
    it { is_expected.to be_show_kpis }
  end

  context 'hide hero' do
    let(:dashboard) { FactoryGirl.create(:dashboard_with_widgets, :display_hero => false) }
    subject {dashboard.decorate}

    it { is_expected.to_not be_show_hero }
    it { is_expected.to be_show_kpis }
  end

  context 'hide kpis' do
    let(:dashboard) { FactoryGirl.create(:dashboard_with_widgets, :display_hero => true, :display_kpis => false) }
    subject {dashboard.decorate}

    it { is_expected.to_not be_show_hero }
    it { is_expected.to_not be_show_kpis }
  end

  describe '.notes' do

    it 'to HTML' do
      # Markdown note data
      dashboard = create(:dashboard)
      dashboard.notes = "This is a simple example of a Markdown document.

Use a blank link between paragraphs.
You can use a bit of **bold** or _italics_. Use backticks to indicate
`code` that will be rendered in monospace.

Here's a list:

                             - an item in the list
      - another item
      - yet another item

      You can include blocks of code using three backticks:

                                                   ```
x <- rnorm(100)
y <- 2*x + rnorm(100)
```

      Or you could indent four spaces:

                                 mean(x)
      sd(x)

      It'll figure out numbered lists, too:

1. First item
2. Second item

And it's easy to create links, like to
      the [Markdown](http://daringfireball.net/projects/markdown/)
      page."

      decorator = DashboardDecorator.new(dashboard)
      html = decorator.to_html

      puts "<========= Test Data ======>"
      puts "#{dashboard.notes}"
      puts "<========= Test Data with HTML Format ======>"
      puts "#{html}"
    end

  end

end
