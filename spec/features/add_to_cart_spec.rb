require 'rails_helper'

RSpec.feature "Visitor can add a product", type: :feature, js: true do

  # SETUP
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

  scenario "They can add a product" do
    # ACT
    visit root_path

    # DEBUG
    

    # VERIFY
    expect(page).to have_css 'article.product'
    page.all('article.product')[0].click_on('Add')
    save_screenshot
    expect(page).to have_content("My Cart (1)")

  end

end