
def create_link
  visit '/links/new'
  fill_in :title, with: 'Kitten Academy'
  fill_in :url, with: 'http://www.kittenacademy.com'
  fill_in :tags, with: 'Kitten'
end

def create_link_with_multi_tags
  visit '/links/new'
  fill_in :title, with: 'Kitten Academy'
  fill_in :url, with: 'http://www.kittenacademy.com'
  fill_in :tags, with: 'Kitten, Animal, Cute'
end
