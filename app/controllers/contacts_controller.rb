class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
      format.yaml { render yaml: @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  # GET /contacts/1.yaml
  def show
    @contact = Contact.find(params[:id])

    json = Hash.new
    json[:Contact] = [@contact.email]
    json.update(:Traits => [ @contact ])
    json.update(:ExtendedTraits => [ @contact.contact_attributes.map { |c| {"#{c.name}" =>  "#{c.value}"} } ].flatten) unless @contact.contact_attributes.nil?
    json.update(:Tags => @contact.tags.map {|t| "#{t.name}" } ).flatten unless @contact.tags.empty?
    if params[:notes] == "true"
      json.update(:Notes => @contact.comments.map { |c| "#{c.comment} (#{c.created_at})"}).flatten unless @contact.comments.empty?
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: json }
      format.yaml { render :text => json.to_yaml }
    end
  end



  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])

    params[:contact].each_with_index do |p, blah|
      ## special case for the tag_list...
      puts "Inspecting...."
      puts params[:contact].inspect
      case p[0]
        when "tag"
          @contact.tag_list = @contact.tag_list + ["#{p[1]}"] unless @contact.tag_list.include? p[1]
        when "rtag"
          @contact.tag_list = @contact.tag_list - ["#{p[1]}"]
        when "note"
          note = Comment.new
          note.comment = p[1]
          @contact.comments = @contact.comments + [ note ]
      else
        puts "Sending #{p[0]} = #{p[1]}"
        puts @contact.inspect
        @contact.send("#{p[0]}=", p[1])
        puts "New Trait: #{@contact.new_trait}"
      end
    end

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Host was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  # GET /contacts.json
  # GET /contacts.yaml
  def list_contacts
    @contacts = Contact.select(:email).all.map(&:email)

    respond_to do |format|
      format.json { render json: @contacts}
      format.yaml { render :text => @contacts.to_yaml }
    end
  end

end
