require 'rails_helper'
require 'spec_helper'

feature ' the signup process' do
  before(:each) do
    visit new_user_url
    fill_in 'Username', with: 'Jon'
    fill_in 'Password', with: 'password'
    click_on 'Create User'
  end

  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Create Account'
  end

  feature 'creating a user' do

    scenario 'redirects to user index page' do
      expect(page).to have_content 'User index page'
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content 'Jon'
    end
  end

  feature 'logging in' do
    before(:each) do
      visit new_session_url
      fill_in 'Username', with: 'Jon'
      fill_in 'Password', with: 'password'
      click_on 'Log In'
    end

    scenario 'shows username on the homepage after login' do
      expect(page).to have_content 'Jon'
    end

  end

  feature 'logging out' do
    scenario 'begins with a logged out state' do
      visit new_session_url
      expect(page).to have_content 'Log In'
    end

    scenario 'doesn\'t show username on the homepage after logout' do
      visit new_session_url
      fill_in 'Username', with: 'Jon'
      fill_in 'Password', with: 'password'
      click_on 'Log In'
      click_on 'Log Out'
      expect(page).to_not have_content 'Jon'
    end

  end

end
