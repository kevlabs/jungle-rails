require 'rails_helper'

RSpec.feature "User can login", type: :feature, js: true do

  before :each do

  @user = User.create!(first_name: "John", last_name: "Doe", email: "john@gmail.com", password: "abc", password_confirmation: "abc")

  end

  scenario "They are redirected to the home page when logging in with valid credentials" do

    visit '/login'

    fill_in "session[email]", with: "john@gmail.com"
    fill_in "session[password]", with: "abc"

    page.find(".btn-primary").click()

    expect(page).to have_css ".products-index"
    

  end

end