require 'spec_helper'

describe "cloud_accounts/show" do
  before(:each) do
    @cloud_account = assign(:cloud_account, stub_model(CloudAccount,
      :name => "Name",
      :charge_index => "Charge Index",
      :customer_type => "Customer Type",
      :organization => "Organization"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Charge Index/)
    rendered.should match(/Customer Type/)
    rendered.should match(/Organization/)
  end
end
