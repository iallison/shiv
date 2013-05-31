require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CloudUsersController do

  # This should return the minimal set of attributes required to create a valid
  # CloudUser. As you add validations to CloudUser, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CloudUsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all cloud_users as @cloud_users" do
      cloud_user = CloudUser.create! valid_attributes
      get :index, {}, valid_session
      assigns(:cloud_users).should eq([cloud_user])
    end
  end

  describe "GET show" do
    it "assigns the requested cloud_user as @cloud_user" do
      cloud_user = CloudUser.create! valid_attributes
      get :show, {:id => cloud_user.to_param}, valid_session
      assigns(:cloud_user).should eq(cloud_user)
    end
  end

  describe "GET new" do
    it "assigns a new cloud_user as @cloud_user" do
      get :new, {}, valid_session
      assigns(:cloud_user).should be_a_new(CloudUser)
    end
  end

  describe "GET edit" do
    it "assigns the requested cloud_user as @cloud_user" do
      cloud_user = CloudUser.create! valid_attributes
      get :edit, {:id => cloud_user.to_param}, valid_session
      assigns(:cloud_user).should eq(cloud_user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CloudUser" do
        expect {
          post :create, {:cloud_user => valid_attributes}, valid_session
        }.to change(CloudUser, :count).by(1)
      end

      it "assigns a newly created cloud_user as @cloud_user" do
        post :create, {:cloud_user => valid_attributes}, valid_session
        assigns(:cloud_user).should be_a(CloudUser)
        assigns(:cloud_user).should be_persisted
      end

      it "redirects to the created cloud_user" do
        post :create, {:cloud_user => valid_attributes}, valid_session
        response.should redirect_to(CloudUser.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cloud_user as @cloud_user" do
        # Trigger the behavior that occurs when invalid params are submitted
        CloudUser.any_instance.stub(:save).and_return(false)
        post :create, {:cloud_user => { "name" => "invalid value" }}, valid_session
        assigns(:cloud_user).should be_a_new(CloudUser)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CloudUser.any_instance.stub(:save).and_return(false)
        post :create, {:cloud_user => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested cloud_user" do
        cloud_user = CloudUser.create! valid_attributes
        # Assuming there are no other cloud_users in the database, this
        # specifies that the CloudUser created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CloudUser.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => cloud_user.to_param, :cloud_user => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested cloud_user as @cloud_user" do
        cloud_user = CloudUser.create! valid_attributes
        put :update, {:id => cloud_user.to_param, :cloud_user => valid_attributes}, valid_session
        assigns(:cloud_user).should eq(cloud_user)
      end

      it "redirects to the cloud_user" do
        cloud_user = CloudUser.create! valid_attributes
        put :update, {:id => cloud_user.to_param, :cloud_user => valid_attributes}, valid_session
        response.should redirect_to(cloud_user)
      end
    end

    describe "with invalid params" do
      it "assigns the cloud_user as @cloud_user" do
        cloud_user = CloudUser.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CloudUser.any_instance.stub(:save).and_return(false)
        put :update, {:id => cloud_user.to_param, :cloud_user => { "name" => "invalid value" }}, valid_session
        assigns(:cloud_user).should eq(cloud_user)
      end

      it "re-renders the 'edit' template" do
        cloud_user = CloudUser.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CloudUser.any_instance.stub(:save).and_return(false)
        put :update, {:id => cloud_user.to_param, :cloud_user => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cloud_user" do
      cloud_user = CloudUser.create! valid_attributes
      expect {
        delete :destroy, {:id => cloud_user.to_param}, valid_session
      }.to change(CloudUser, :count).by(-1)
    end

    it "redirects to the cloud_users list" do
      cloud_user = CloudUser.create! valid_attributes
      delete :destroy, {:id => cloud_user.to_param}, valid_session
      response.should redirect_to(cloud_users_url)
    end
  end

end
