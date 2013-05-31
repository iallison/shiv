require "spec_helper"

describe CloudAccountsController do
  describe "routing" do

    it "routes to #index" do
      get("/cloud_accounts").should route_to("cloud_accounts#index")
    end

    it "routes to #new" do
      get("/cloud_accounts/new").should route_to("cloud_accounts#new")
    end

    it "routes to #show" do
      get("/cloud_accounts/1").should route_to("cloud_accounts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cloud_accounts/1/edit").should route_to("cloud_accounts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cloud_accounts").should route_to("cloud_accounts#create")
    end

    it "routes to #update" do
      put("/cloud_accounts/1").should route_to("cloud_accounts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cloud_accounts/1").should route_to("cloud_accounts#destroy", :id => "1")
    end

  end
end
