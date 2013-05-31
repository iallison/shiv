require 'spec_helper'

describe "cloud_users/show" do
  before(:each) do
    @cloud_user = assign(:cloud_user, stub_model(CloudUser,
      :name => "Name",
      :admin => "",
      :contact_id => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
