ENV["RACK_ENV"] ||= 'development'

require 'sinatra/base'
require_relative './models/link.rb'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  post "/links" do
    link = Link.new(url: params[:url], title: params[:title])
    tag_names = params[:tags].split(",").map!(&:strip)
    p tag_names
    tags = tag_names.map {|tag| Tag.first_or_create(name: tag)}
    p tags
    tag = Tag.first_or_create(name: params[:tags])
    p tag
    tags.each {|tag| link.tags << tag}
    p link.tags
    link.save
    p link
    redirect "/links"
  end

  get "/links/new" do
    erb :add_link
  end

  get "/tags/:name" do
    tag = Tag.first(name: params[:tags])
    p tag
    @tag_names = params[:tags].split(",").map!(&:strip)
    p @tag_names
    @links = tag.links
    erb :tags
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
