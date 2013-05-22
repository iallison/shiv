require 'spec_helper'

describe "boxes/index" do
  before(:each) do
    assign(:boxes, [
      stub_model(Box,
        :name => "Name",
        :location => "Location",
        :serial => "Serial",
        :model => "Model",
        :vendor => "Vendor"
      ),
      stub_model(Box,
        :name => "Name",
        :location => "Location",
        :serial => "Serial",
        :model => "Model",
        :vendor => "Vendor"
      )
    ])
  end

  it "renders a list of boxes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Serial".to_s, :count => 2
    assert_select "tr>td", :text => "Model".to_s, :count => 2
    assert_select "tr>td", :text => "Vendor".to_s, :count => 2
  end
end
