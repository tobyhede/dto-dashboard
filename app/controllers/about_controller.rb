class AboutController < ApplicationController

  include AboutHelper


  def index
    @title = "Copyright"
    @description = "Copyright"

    render :copyright
  end

end
