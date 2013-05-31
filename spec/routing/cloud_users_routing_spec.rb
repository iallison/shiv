require "spec_helper"

describe CloudUsersController do
  describe "routing" do

    it "routes to #index" do
      get("/cloud_users").should route_to("cloud_users#index")
    end

    it "routes to #new" do
      get("/cloud_users/new").should route_to("cloud_users#new")
    end

    it "routes to #show" do
      get("/cloud_users/1").should route_to("cloud_users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cloud_users/1/edit").should route_to("cloud_users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cloud_users").should route_to("cloud_users#create")
    end

    it "routes to #update" do
      put("/cloud_users/1").should route_to("cloud_users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cloud_users/1").should route_to("cloud_users#destroy", :id => "1")
    end

  end
end
