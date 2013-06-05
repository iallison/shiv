class BoxesController < ApplicationController
  # GET /boxes
  # GET /boxes.json
  def index
    @boxes = Box.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boxes }
    end
  end

  # GET /boxes/1
  # GET /boxes/1.json
  # GET /boxes/1.yaml
  def show
    @box = Box.includes(:hosts).find(params[:id])

    json = Hash.new
    json[:Box] = [@box.name]
    json.update(:Hostings => @box.hosts.map { |h| "#{h.name}"}  ) unless @box.hosts.empty?
    json.update(:Traits => [ @box ])
    json.update(:ExtendedTraits => [ @box.box_attributes.map { |a| {"#{a.name}" =>  "#{a.value}"} } ].flatten) unless @box.box_attributes.empty?
    json.update(:Tags => @box.tags.map {|t| "#{t.name}" } ).flatten unless @box.tags.empty?
    if params[:notes] == "true"
      json.update(:Notes => @box.comments.map { |c| "#{c.comment} (#{c.created_at})"}).flatten unless @box.comments.empty?
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: json }
      format.yaml { render :text => json.to_yaml }
    end
  end

  # GET /boxes/new
  # GET /boxes/new.json
  def new
    @box = Box.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @box }
    end
  end

  # GET /boxes/1/edit
  def edit
    @box = Box.find(params[:id])
  end

  # POST /boxes
  # POST /boxes.json
  def create
    @box = Box.new(params[:box])

    respond_to do |format|
      if @box.save
        @box.name = "%s%06d" % ["CM", @box.id]
        @box.save
        format.html { redirect_to @box, notice: 'Box was successfully created.' }
        format.json { render json: @box, status: :created, location: @box }
      else
        format.html { render action: "new" }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boxes/1
  # PUT /boxes/1.json
  def update
    @box = Box.find(params[:id])

    params[:box].each_with_index do |p, blah|
      ## special case for the tag_list...
      case p[0]
        when "tag"
          @box.tag_list = @box.tag_list + ["#{p[1]}"] unless @box.tag_list.include? p[1]
        when "rtag"
          @box.tag_list = @box.tag_list - ["#{p[1]}"]
        when "note"
          note = Comment.new
          note.comment = p[1]
          @box.comments = @box.comments + [ note ]
      else
        @box.send("#{p[0]}=", p[1])
      end
    end

    respond_to do |format|
      if @box.save
        format.html { redirect_to @box, notice: 'Box was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /boxes/1
  # DELETE /boxes/1.json
  def destroy
    @box = Box.find(params[:id])
    @box.destroy

    respond_to do |format|
      format.html { redirect_to boxes_url }
      format.json { head :no_content }
    end
  end

  def tagged
    if params[:tag].present?
      @boxes = Box.tagged_with(params[:tag])
    else
      @boxes = Box.boxall
    end
  end

  def list_boxes
    @boxes = Box.select(:name).all.map(&:name)

    respond_to do |format|
      format.json { render json: @boxes}
      format.yaml { render :text => @boxes.to_yaml }
    end
  end


end
