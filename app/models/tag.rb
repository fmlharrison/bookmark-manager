require 'data_mapper'
require 'dm-postgres-adapter'

class Tag

  include DataMapper::Resource

  has n, :links, through: Resource

  property :id, Serial
  property :name, String

  def self.create_tags(tag_names)
  	tag_names.map {|tag| Tag.first_or_create(name: tag)}
  end

end
