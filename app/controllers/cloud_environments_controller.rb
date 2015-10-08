class CloudEnvironmentsController < ApplicationController
  # GET /cloud_environments
  # GET /cloud_environments.json
  def index
    @cloud_environments = CloudEnvironment.order('name')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cloud_environments }
    end
  end

  # GET /cloud_environments/1
  # GET /cloud_environments/1.json
  def show
    @cloud_environment = CloudEnvironment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cloud_environment }
    end
  end

  # GET /cloud_environments/new
  # GET /cloud_environments/new.json
  def new
    @cloud_environment = CloudEnvironment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cloud_environment }
    end
  end

  # GET /cloud_environments/1/edit
  def edit
    @cloud_environment = CloudEnvironment.find(params[:id])
  end

  # POST /cloud_environments
  # POST /cloud_environments.json
  def create
    @cloud_environment = CloudEnvironment.new(params[:cloud_environment])

    respond_to do |format|
      if @cloud_environment.save
        format.html { redirect_to @cloud_environment, notice: 'Cloud environment was successfully created.' }
        format.json { render json: @cloud_environment, status: :created, location: @cloud_environment }
      else
        format.html { render action: "new" }
        format.json { render json: @cloud_environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cloud_environments/1
  # PUT /cloud_environments/1.json
  def update
    @cloud_environment = CloudEnvironment.find(params[:id])

    respond_to do |format|
      if @cloud_environment.update_attributes(params[:cloud_environment])
        format.html { redirect_to @cloud_environment, notice: 'Cloud environment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cloud_environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cloud_environments/1
  # DELETE /cloud_environments/1.json
  def destroy
    @cloud_environment = CloudEnvironment.find(params[:id])
    @cloud_environment.destroy

    respond_to do |format|
      format.html { redirect_to cloud_environments_url }
      format.json { head :no_content }
    end
  end
end
