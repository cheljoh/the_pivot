require "rails_helper"

RSpec.feature "AdminCanDeactivateAProduct", type: :feature do
  # could potentially use similar test for removing listing or event/venue
  scenario "they are able to deactivate an item" do
    pending
    admin = User.create(fullname: "john adams",
                        email: "admin@example.com",
                        password: "password",
                        role: 1)

    category = Category.create(name: "coffee")
    product = category.products.create(name: "Ethiopian",
                                       price:1500,
                                       description: "Ethiopian coffee is super good",
                                      )

    visit "/"
    click_on "login"
    fill_in "email", with: admin.email
    fill_in "password", with: admin.password

    click_on "login"

    visit admin_dashboard_path

    click_on "active products"

    expect(current_path).to eq(admin_products_path)

    within "tr##{product.id}-product" do
      find(:css, "#product_inactive").set(true)
      click_on "update product"
    end

    expect(page).to have_content("Ethiopian has been deactivated")

    click_on "inactive products"

    expect(current_path).to eq(admin_products_path)

    within "tr##{product.id}-product" do
      click_on "update product"
    end

    expect(page).to have_content("Sorry mate! Reactivate the product!")

    within "tr##{product.id}-product" do
      find(:css, "#product_inactive").set(false)
      click_on "update product"
    end

    expect(page).to have_content("Ethiopian has been activated")
  end
end
