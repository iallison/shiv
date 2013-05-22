require 'spec_helper'

describe "hosts/edit" do
  before(:each) do
    @host = assign(:host, stub_model(Host,
      :name => "MyString",
      :kernel => "MyString",
      :operating_system => "MyString",
      :os_release => "MyString",
      :ip => "MyString"
    ))
  end

  it "renders the edit host form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", host_path(@host), "post" do
      assert_select "input#host_name[name=?]", "host[name]"
      assert_select "input#host_kernel[name=?]", "host[kernel]"
      assert_select "input#host_operating_system[name=?]", "host[operating_system]"
      assert_select "input#host_os_release[name=?]", "host[os_release]"
      assert_select "input#host_ip[name=?]", "host[ip]"
    end
  end
end
