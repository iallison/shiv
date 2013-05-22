require 'spec_helper'

describe "boxes/edit" do
  before(:each) do
    @box = assign(:box, stub_model(Box,
      :name => "MyString",
      :location => "MyString",
      :serial => "MyString",
      :model => "MyString",
      :vendor => "MyString"
    ))
  end

  it "renders the edit box form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", box_path(@box), "post" do
      assert_select "input#box_name[name=?]", "box[name]"
      assert_select "input#box_location[name=?]", "box[location]"
      assert_select "input#box_serial[name=?]", "box[serial]"
      assert_select "input#box_model[name=?]", "box[model]"
      assert_select "input#box_vendor[name=?]", "box[vendor]"
    end
  end
end
