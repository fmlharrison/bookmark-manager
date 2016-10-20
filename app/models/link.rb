require 'data_mapper'
require 'dm-postgres-adapter'

class Link

  # DataMapper::Logger.new($stdout, :debug)

  include DataMapper::Resource

  has n, :tags, through: Resource

  property :id,      Serial
  property :title,   String
  property :url,     String

end
