require 'spec_helper'

describe "hosts/index" do
  before(:each) do
    assign(:hosts, [
      stub_model(Host,
        :name => "Name",
        :kernel => "Kernel",
        :operating_system => "Operating System",
        :os_release => "Os Release",
        :ip => "Ip"
      ),
      stub_model(Host,
        :name => "Name",
        :kernel => "Kernel",
        :operating_system => "Operating System",
        :os_release => "Os Release",
        :ip => "Ip"
      )
    ])
  end

  it "renders a list of hosts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Kernel".to_s, :count => 2
    assert_select "tr>td", :text => "Operating System".to_s, :count => 2
    assert_select "tr>td", :text => "Os Release".to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
  end
end
