require 'rails_helper'

RSpec.feature "Cart quantity updates", type: :feature, js: true do

  before :each do
  @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can add the first product to the cart and the cart quantity updates" do
    visit root_path

    expect(page).to have_text "My Cart (0)"

    product = page.first("article.product")
    product.find(".btn-primary").click()

    expect(page).to have_text "My Cart (1)"

  end

end