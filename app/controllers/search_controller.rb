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
    puts "searchAll controller"
    search_text = params[:search_text]
    #@hosts = Host.find(:all, :conditions => ['lower(name) LIKE ? OR operating_system LIKE ?', "%#{params[:search_text].downcase}%", "%#{params[:search_text].downcase}%"])
     @hosts = Host.where(%q[ lower(name) LIKE :search OR  
                              lower(operating_system) LIKE :search OR
                              lower(ip) LIKE :search OR
                              lower(memory) LIKE :search OR
                              lower(serial) LIKE :search OR
                              lower(os_release) LIKE :search OR
                              lower(cloud_environment) LIKE :search OR
                              lower(nic1_macaddress) LIKE :search OR
                              lower(ipmi_ipaddress) LIKE :search OR
                              lower(ipmi_macaddress) LIKE :search  ], :search=>"%#{params[:search_text].downcase.strip}%").all
    #@hosts = Host.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:search_text].downcase}%"])
    puts "HOSTS #{@hosts} "
    @host_attributes = HostAttributes.find(:all, :conditions => ['lower(name) LIKE ?', "%#{params[:search_text].downcase}%"])
    puts "SEARCH #{params[:search_text].downcase}  ATTRS #{@host_attributes.inspect}"
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

  def searchTrait
    trait_name,trait_value = params[:search_text].split("=")
    @hosts = Host.find(:all, :conditions => ["lower(#{trait_name}) LIKE ?", "%#{trait_value.downcase}%"])
    @host_attributes = HostAttributes.find(:all, :conditions => ["lower(name) LIKE ?", "%#{trait_value.downcase}%"])

    @host_attributes.each do |h|
      @hosts << Host.find("#{h[:host_id]}")
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
