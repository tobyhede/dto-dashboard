class AboutController < AuthenticatedController

  def index
    render :copyright
  end

end
