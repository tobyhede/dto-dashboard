module DashboardHelper

  def DashboardHelper.sizeToStyle(size)
    cls = case size
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
    return cls
  end

  def DashboardHelper.truncateDashboardName(name)

  end

  class Helper
    def initialize(name, artist, duration)
      @name = name
      @artist = artist
      @duration = duration
    end

  end

end
