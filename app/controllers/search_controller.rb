class SearchController < ApplicationController

  def searchAll
    @hosts = Host.find(:all, :conditions => ['name LIKE ?', "%#{params[:search_text]}%"])
    Host.tagged_with([params[:search_text]], :wild => true, :any => true).each do |h|
      @hosts << h
    end

    @boxes = Box.find(:all, :conditions => ['name LIKE ?', "%#{params[:search_text]}%"])
    Box.tagged_with([params[:search_text]], :wild => true, :any => true).each do |b|
      @boxes << b
    end
  end

end
