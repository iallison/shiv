require 'spec_helper'

describe "cloud_accounts/edit" do
  before(:each) do
    @cloud_account = assign(:cloud_account, stub_model(CloudAccount,
      :name => "MyString",
      :charge_index => "MyString",
      :customer_type => "MyString",
      :organization => "MyString"
    ))
  end

  it "renders the edit cloud_account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cloud_account_path(@cloud_account), "post" do
      assert_select "input#cloud_account_name[name=?]", "cloud_account[name]"
      assert_select "input#cloud_account_charge_index[name=?]", "cloud_account[charge_index]"
      assert_select "input#cloud_account_customer_type[name=?]", "cloud_account[customer_type]"
      assert_select "input#cloud_account_organization[name=?]", "cloud_account[organization]"
    end
  end
end
