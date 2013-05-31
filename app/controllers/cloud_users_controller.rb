class CloudUsersController < ApplicationController
  # GET /cloud_users
  # GET /cloud_users.json
  def index
    @cloud_users = CloudUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cloud_users }
    end
  end

  # GET /cloud_users/1
  # GET /cloud_users/1.json
  def show
    @cloud_user = CloudUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cloud_user }
    end
  end

  # GET /cloud_users/new
  # GET /cloud_users/new.json
  def new
    @cloud_user = CloudUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cloud_user }
    end
  end

  # GET /cloud_users/1/edit
  def edit
    @cloud_user = CloudUser.find(params[:id])
  end

  # POST /cloud_users
  # POST /cloud_users.json
  def create
    @cloud_user = CloudUser.new(params[:cloud_user])

    respond_to do |format|
      if @cloud_user.save
        format.html { redirect_to @cloud_user, notice: 'Cloud user was successfully created.' }
        format.json { render json: @cloud_user, status: :created, location: @cloud_user }
      else
        format.html { render action: "new" }
        format.json { render json: @cloud_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cloud_users/1
  # PUT /cloud_users/1.json
  def update
    @cloud_user = CloudUser.find(params[:id])

    respond_to do |format|
      if @cloud_user.update_attributes(params[:cloud_user])
        format.html { redirect_to @cloud_user, notice: 'Cloud user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cloud_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cloud_users/1
  # DELETE /cloud_users/1.json
  def destroy
    @cloud_user = CloudUser.find(params[:id])
    @cloud_user.destroy

    respond_to do |format|
      format.html { redirect_to cloud_users_url }
      format.json { head :no_content }
    end
  end
end
