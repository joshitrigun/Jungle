require 'rails_helper'

RSpec.feature "Visitor navigates to the homepage page", type: :feature, js: true do


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

  scenario "They see all products and click add to cart button" do
    # ACT
    visit root_path

    #CLICK
    # click_on ".btn-default"
    first(".btn.btn-primary").click()
    
    
    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_text 'My Cart (1)'
  end

end
