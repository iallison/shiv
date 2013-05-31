require 'spec_helper'

describe "cloud_accounts/index" do
  before(:each) do
    assign(:cloud_accounts, [
      stub_model(CloudAccount,
        :name => "Name",
        :charge_index => "Charge Index",
        :customer_type => "Customer Type",
        :organization => "Organization"
      ),
      stub_model(CloudAccount,
        :name => "Name",
        :charge_index => "Charge Index",
        :customer_type => "Customer Type",
        :organization => "Organization"
      )
    ])
  end

  it "renders a list of cloud_accounts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Charge Index".to_s, :count => 2
    assert_select "tr>td", :text => "Customer Type".to_s, :count => 2
    assert_select "tr>td", :text => "Organization".to_s, :count => 2
  end
end
