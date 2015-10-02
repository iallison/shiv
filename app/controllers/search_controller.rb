class SearchController < ApplicationController

  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hosts }
      format.yaml { render :text => @hosts.to_yaml }
    end

  end

  def show
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hosts }
      format.yaml { render :text => @hosts.to_yaml }
    end

  end


  def searchAll

    @hosts = Host.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:search_text].downcase}%"])
    @host_attributes = HostAttributes.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:search_text].downcase}%"])

    @host_attributes.each do |h|
      @hosts << Host.find("#{h[:host_id]}")
    end

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


  def searchContact
    @contacts = Contact.find(:all, :conditions => ['lower(email) LIKE ?', "%#{params[:search_text].downcase}%"])
    Contact.tagged_with([params[:search_text]], :wild => true, :any => true).each do |c|
      @contacts << c unless @contacts.include? c
    end

    respond_to do |format|
      format.html
      format.json { render json: @contacts }
      format.yaml { render :text => @contacts.to_yaml }
    end

  end


end
