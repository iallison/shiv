require 'spec_helper'

describe "cloud_users/edit" do
  before(:each) do
    @cloud_user = assign(:cloud_user, stub_model(CloudUser,
      :name => "MyString",
      :admin => "",
      :contact_id => ""
    ))
  end

  it "renders the edit cloud_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cloud_user_path(@cloud_user), "post" do
      assert_select "input#cloud_user_name[name=?]", "cloud_user[name]"
      assert_select "input#cloud_user_admin[name=?]", "cloud_user[admin]"
      assert_select "input#cloud_user_contact_id[name=?]", "cloud_user[contact_id]"
    end
  end
end
