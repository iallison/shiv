class UsersController < ApplicationController
  def index
    @users = User.all
    @role_mapping = { 1 => "root", 2 => "admin", 4 => "guest" }
    puts "MAP #{@role_mapping[2]}"
    puts @users.to_yaml
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end

  end

  # GET /admin/1/edit
  def edit
    @user = User.find(params[:id])
    #puts "ROLE #{User.valid_roles}"
    @myroles = [ 'root','admin','guest']
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end


  # PUT /cloud_users/1
  # PUT /cloud_users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cloud_users/1
  # DELETE /cloud_users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to cloud_users_url }
      format.json { head :no_content }
    end
  end
    
end
