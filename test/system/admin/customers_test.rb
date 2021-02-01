require "application_system_test_case"

class Admin::CustomersTest < ApplicationSystemTestCase
  setup do
    @admin_customer = admin_customers(:one)
  end

  test "visiting the index" do
    visit admin_customers_url
    assert_selector "h1", text: "Admin/Customers"
  end

  test "creating a Customer" do
    visit admin_customers_url
    click_on "New Admin/Customer"

    click_on "Create Customer"

    assert_text "Customer was successfully created"
    click_on "Back"
  end

  test "updating a Customer" do
    visit admin_customers_url
    click_on "Edit", match: :first

    click_on "Update Customer"

    assert_text "Customer was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer" do
    visit admin_customers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer was successfully destroyed"
  end
end
