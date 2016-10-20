require 'spec_helper'

feature 'Search by tags' do
  scenario 'shows tagged links only' do
    create_link
    click_button 'Add'
    fill_in :tags, with: 'Kitten'
    click_button 'Search'
    expect(page).to have_content("Kitten Academy")
  end

end
