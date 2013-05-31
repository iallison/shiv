require 'spec_helper'

describe "cloud_users/index" do
  before(:each) do
    assign(:cloud_users, [
      stub_model(CloudUser,
        :name => "Name",
        :admin => "",
        :contact_id => ""
      ),
      stub_model(CloudUser,
        :name => "Name",
        :admin => "",
        :contact_id => ""
      )
    ])
  end

  it "renders a list of cloud_users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
