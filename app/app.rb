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
    tag = Tag.first_or_create(name: params[:tags])
    link.tags << tag
    link.save
    redirect "/links"
  end

  get "/links/new" do
    erb :add_link
  end

  get "/tags/:name" do
    tag = Tag.first(name: params[:tags])
    @tag_name = params[:tags]
    @links = tag.links
    erb :tags
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
