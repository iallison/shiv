require 'spec_helper'

describe "hosts/show" do
  before(:each) do
    @host = assign(:host, stub_model(Host,
      :name => "Name",
      :kernel => "Kernel",
      :operating_system => "Operating System",
      :os_release => "Os Release",
      :ip => "Ip"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Kernel/)
    rendered.should match(/Operating System/)
    rendered.should match(/Os Release/)
    rendered.should match(/Ip/)
  end
end
