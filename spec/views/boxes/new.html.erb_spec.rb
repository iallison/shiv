require 'spec_helper'

describe "boxes/new" do
  before(:each) do
    assign(:box, stub_model(Box,
      :name => "MyString",
      :location => "MyString",
      :serial => "MyString",
      :model => "MyString",
      :vendor => "MyString"
    ).as_new_record)
  end

  it "renders new box form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", boxes_path, "post" do
      assert_select "input#box_name[name=?]", "box[name]"
      assert_select "input#box_location[name=?]", "box[location]"
      assert_select "input#box_serial[name=?]", "box[serial]"
      assert_select "input#box_model[name=?]", "box[model]"
      assert_select "input#box_vendor[name=?]", "box[vendor]"
    end
  end
end
