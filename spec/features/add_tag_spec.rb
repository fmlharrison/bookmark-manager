require 'spec_helper'

feature 'Adding tags to links' do
  scenario 'Assign tags to a link' do
    create_link
    click_button 'Add'
    link = Link.first
    expect(link.tags.map(&:name)).to include('Kitten')
  end
end
