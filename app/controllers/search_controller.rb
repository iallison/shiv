class SearchController < ApplicationController

  def searchAll
    @hosts = Host.find(:all, :conditions => ['name LIKE ?', "%#{params[:search_text]}%"])
    @boxes = Box.find(:all, :conditions => ['name LIKE ?', "%#{params[:search_text]}%"])

  end

end
