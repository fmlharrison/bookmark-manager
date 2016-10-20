require 'spec_helper'

feature 'Search by tags' do
  scenario 'shows tagged links only' do
    create_link
    click_button 'Add'
    fill_in :tags, with: 'Kitten'
    click_button 'Search'
    expect(page).to have_content("Kitten Academy")
  end

  scenario 'Adding multipule tags', focus: true do
    create_link_with_multi_tags
    click_button 'Add'
    fill_in :tags, with: 'Kitten, Animal, Cute'
    click_button 'Search'

    link = Link.first
    expect(link.tags.map(&:name)).to include('Kitten', 'Animal', 'Cute')
  end
end
