require 'rails_helper'

RSpec.feature "UserRemovesAProductFromCarts", type: :feature do
  scenario "they see all that the removed item is no longer there" do
    pending
    category = Category.create(name:"coffee")
    product = category.products.create(name:"Ethiopian", price:1500, description:"Ethiopian coffee is super good")

    product2 = category.products.create(name:"Columbian", price:1800, description:"Columbian coffee is super good")
    visit "/products/#{product.id}"
    click_on "Add to cart"

    visit "/products/#{product2.id}"
    click_on "Add to cart"

    visit cart_path

    within("div##{product.id}-product") do
      click_on "remove from cart"
    end

    expect(current_path).to eq(cart_path)

    expect(page).to have_content("You have removed #{product.name} from your cart.")

    expect(page).to_not have_content(product.description)
    expect(page).to_not have_content(product.price/100)

    expect(page).to have_link "#{product.name}"
    expect(page).to have_content("$18")
  end
end
