class StaticSiteController < ApplicationController

  layout false, only: :home

  def home
  end
  
end
