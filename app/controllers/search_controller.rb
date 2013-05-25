class SearchController < ApplicationController

  def searchAll
    @hosts = Host.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:search_text].downcase}%"])
    Host.tagged_with([params[:search_text]], :wild => true, :any => true).each do |h|
      @hosts << h unless @hosts.include? h
    end

    @boxes = Box.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:search_text].downcase}%"])
    Box.tagged_with([params[:search_text]], :wild => true, :any => true).each do |b|
      @boxes << b unless @boxes.include? b
    end

    respond_to do |format|
      format.html
      format.json { render json: @hosts }
      format.yaml { render :text => @hosts.to_yaml }
    end
  end

  def searchHost
    @hosts = Host.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:search_text].downcase}%"])
    Host.tagged_with([params[:search_text]], :wild => true, :any => true).each do |h|
      @hosts << h unless @hosts.include? h
    end

    respond_to do |format|
      format.html
      format.json { render json: @hosts }
      format.yaml { render :text => @hosts.to_yaml }
    end

  end

  def searchBox
    @boxes = Box.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:search_text].downcase}%"])
    Box.tagged_with([params[:search_text]], :wild => true, :any => true).each do |h|
      @boxes << h unless @boxes.include? h
    end

    respond_to do |format|
      format.html
      format.json { render json: @boxes }
      format.yaml { render :text => @boxes.to_yaml }
    end

  end

end
